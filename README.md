# SSC0958 - Projeto II - Smart Home Smart Contract with IoT Integration and Automated Testing  

Este repositório contém o código-fonte de um contrato inteligente para um sistema de casa inteligente (Smart Home), que utiliza a tecnologia IoT para fornecer uma experiência integrada e automatizada para os usuários. Além disso, inclui um testador automático desenvolvido em JavaScript com o auxílio do framework Flutter.  

# Visão Geral  
## Contrato Inteligente (Smart Contract)  

O contrato inteligente é desenvolvido para ser executado em uma blockchain, garantindo transparência e segurança nas transações relacionadas à automação residencial.  
 

## Testador Automático  

O testador automático é uma ferramenta crucial para garantir a robustez e confiabilidade do contrato inteligente. Desenvolvido em JavaScript com o auxílio do Truffle, o testador simula cenários de uso, verifica a execução correta das funções.  

# Como Começar  

## Clone o Repositório:  

execute o seguinte comando para clonar o repositório: git clone https://github.com/brubru8888/SSC0958-II.git  

## Instale as Dependências:  

Instale as dependências do contrato inteligente e do testador automático. No caso do contrato inteligente ele pode ser executado no Remix IDE. Já para o Truffle siga os seguintes passos:

Instale o Truffle CLI globalmente executando o seguinte comando:  

npm install -g truffle  

Assim que a instalação for concluída, verifique se o Truffle CLI foi instalado corretamente executando o seguinte comando:  

truffle version  

Instale dependências adicionais necessárias para o Truffle CLI, como o Ganache CLI. Para instalar o Ganache CLI, por exemplo, execute o seguinte comando:

npm install -g ganache  

Para executar todos os testes, basta executar:

truffle test  
 
Alternativamente, você pode especificar um caminho para um arquivo específico que deseja executar, por exemplo:  

truffle test ./path/to/test/file.js  


## Configuração do Ambiente:  

Configure as variáveis de ambiente necessárias para a execução do contrato inteligente e do testador automático.  

# Licença  

Este projeto é licenciado sob os termos da Licença MIT. Leia o arquivo LICENSE para obter mais informações.  
