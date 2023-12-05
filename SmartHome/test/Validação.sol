// SPDX-License-Identifier: MIT
// Identificador de licença para indicar o tipo de licença aplicada ao contrato (MIT neste caso)
pragma solidity >=0.6.0 <0.9.0;

// Contrato IoTSmartHome
contract IoTSmartHome {

    // Endereço do proprietário do contrato
    address public owner;

    // Mapeamento para armazenar os inscritos (subscribers)
    mapping(address => bool) public subscribers;

    // Modificador para permitir apenas o proprietário executar uma função
    modifier onlyOwner() {
        require(msg.sender == owner, "Somente o dono pode chamar essa funcao");
        _;
    }

    // Modificador para permitir apenas inscritos executar uma função
    modifier onlySubscribers() {
        require(subscribers[msg.sender], "Somente os inscritos pode chamar essa funcao");
        _;
    }

    // Mapeamento para armazenar as inscrições para cada tópico
    mapping(string => address[]) private topicSubscribers;

    // Mapeamento para armazenar os últimos dados publicados para cada tópico
    mapping(string => string) private lastPublishedData;

    // Evento para registrar comunicação de dados
    event DataPublished(string topic, string data, address publisher);

    // Construtor do contrato
    constructor() {
        owner = msg.sender;
    }

    // Função para inscrever um endereço em um tópico
    function subscribe(string memory topic) public {
        require(!subscribers[msg.sender], "Ja esta inscrito");
        topicSubscribers[topic].push(msg.sender);
        subscribers[msg.sender] = true;
    }

    // Função para cancelar a inscrição em um tópico
    function unsubscribe(string memory topic) public onlySubscribers {
        address[] storage topicSubs = topicSubscribers[topic];
        bool found = false;

        for (uint i = 0; i < topicSubs.length; i++) {
            if (topicSubs[i] == msg.sender) {
                // Remove o inscrito trocando com o último elemento e reduzindo o tamanho do array
                topicSubs[i] = topicSubs[topicSubs.length - 1];
                topicSubs.pop();
                found = true;
                break;
            }
        }

        require(found, "Sem inscritos para esse topico");
        subscribers[msg.sender] = false;
    }

    // Função para publicar dados em um tópico com integridade e autenticação
    function publishData(string memory topic, string memory data) public onlyOwner {
        require(topicSubscribers[topic].length > 0, "Sem inscritos para esse topico");

        // Garante que o proprietário seja o publicador
        require(msg.sender == owner, "Somente o dono pode publicar dados");

        // Atualiza os últimos dados publicados para o tópico
        lastPublishedData[topic] = data;

        // Emite o evento de publicação de dados
        emit DataPublished(topic, data, msg.sender);
    }

    // Função para obter os últimos dados publicados para um tópico
    function getLastPublishedData(string memory topic) public view returns (string memory) {
        return lastPublishedData[topic];
    }
}