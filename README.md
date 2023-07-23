PT_BR:

Fala coder!
Para instalar o backend apenas extraia os arquivos e você vai apenas precisar da pasta chamada "backend".
Para iniciar o backend vocês precisa:

1- Abrir o prompt de comando ou terminal e digitar:
dart pub global activate json_server_api

2- Após instalar o json_server_api na sua máquina você precisa pegar o ip local da sua máquina para rodar o backend,
para isso:

Windows - Abra o prompt de comando e digite ipconfig e pressione enter.
Copie o endereço que começa com 192.168. Ele é parecido com algo como 192.168.20.3.

macOS - Abra o terminal e digite ifconfig e pressione enter.
Copie o endereço que começa com 192.168. Ele é parecido com algo como 192.168.20.3.

3- Após copiar o endereço de IP abra a pasta "backend" pelo terminal ou prompt de comando e rode o seguinte:

jsonserverapi -h SEU_IP_LOCAL -p 8080 -d api.json

Troque SEU_IP_LOCAL para seu ip, no meu caso seria 192.168.20.3

4 - Pronto! Seu backend deve estar rodando normalmente!

US_EN:

Hello coder!

To install the backend, simply extract the files, and you will only need the folder called "backend".

To start the backend, follow these steps:

1- Open the command prompt or terminal and type:
dart pub global activate json_server_api

2- After installing json_server_api on your machine, you need to get the local IP address of your machine to run the backend. Here's how:

For Windows:

Open the command prompt and type: ipconfig
Copy the address that starts with 192.168. It will look something like 192.168.20.3.
For macOS:

3- Open the terminal and type: ifconfig
Copy the address that starts with 192.168. It will look something like 192.168.20.3.
Once you have copied the IP address, open the "backend" folder in the terminal or command prompt and run the following command:

jsonserverapi -h YOUR_LOCAL_IP -p 8080 -d api.json

Replace YOUR_LOCAL_IP with your IP address. For example, if your IP address is 192.168.20.3, it should be like this:

jsonserverapi -h 192.168.20.3 -p 8080 -d api.json

4- Great! Your backend should now be up and running smoothly!
