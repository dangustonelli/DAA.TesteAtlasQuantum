1. Execute o script na inst�ncia local (MSSQLLocalDB):
	Server name: (localdb)\mssqllocaldb
	Authentication: Windows Authentication

2. URLs
	 - Lista todas as transa��es: https://localhost:44337/api/transacoes (GET)
	 - Lista transa��es por ID : https://localhost:44337/api/transacoes/1 (GET)
	 - Insere transa��es: https://localhost:44337/api/transacoes (POST)