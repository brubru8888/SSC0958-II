const IoTSmartHome = artifacts.require("IoTSmartHome");

contract("IoTSmartHome", (accounts) => {
  let iotSmartHome;

  // Define o endereço do dono para facilitar os testes
  const owner = accounts[0];

  beforeEach(async () => {
    iotSmartHome = await IoTSmartHome.new({ from: owner });
  });

  it("deveria permitir que o dono publique dados", async () => {
    const topic = "Temperatura";
    const data = "25°C";

    // Adiciona um assinante ao tópico antes de tentar publicar dados
    await iotSmartHome.subscribe(topic, { from: accounts[1] });

    const result = await iotSmartHome.publishData(topic, data, { from: owner });

    assert.equal(result.logs.length, 1, "Deveria emitir um evento");
    assert.equal(result.logs[0].event, "DataPublished", "Deveria ser o evento DataPublished");
    assert.equal(result.logs[0].args.topic, topic, "Tópico deveria ser o mesmo");
    assert.equal(result.logs[0].args.data, data, "Dados deveriam ser os mesmos");
    assert.equal(result.logs[0].args.publisher, owner, "Publicador deveria ser o dono");

    const lastPublishedData = await iotSmartHome.getLastPublishedData(topic);
    assert.equal(lastPublishedData, data, "Deveria ter o último dado publicado");
  });

  it("não deveria permitir que não assinantes publiquem dados", async () => {
    const nonSubscriber = accounts[1];
    const topic = "Luz";
    const data = "Ligada";

    // Tenta publicar dados como não assinante
    try {
      await iotSmartHome.publishData(topic, data, { from: nonSubscriber });
      assert.fail("Deveria falhar ao publicar dados como não assinante");
    } catch (error) {
      assert.include(
        error.message,
        "Somente o dono pode chamar essa funcao",
        "Deveria falhar com a mensagem correta"
      );
    }
  });

  it("deveria permitir que assinantes se inscrevam e cancelem a inscrição", async () => {
    const subscriber = accounts[1];
    const topic = "UmTopico";

    // Verifica a inscrição inicial
    assert.equal(await iotSmartHome.subscribers(subscriber), false, "Deveria começar não inscrito");

    // Inscreve o assinante
    await iotSmartHome.subscribe(topic, { from: subscriber });
    assert.equal(await iotSmartHome.subscribers(subscriber), true, "Deveria estar inscrito após a inscrição");

    // Cancela a inscrição do assinante
    await iotSmartHome.unsubscribe(topic, { from: subscriber });
    assert.equal(await iotSmartHome.subscribers(subscriber), false, "Deveria estar não inscrito após cancelar a inscrição");
  });
});