const http = require('http');

const server = http.createServer((req, res) => {
	const response = {
		message: "hello from Linux server",
		timestamp: new Date().toISOString(),
		random: Math.floor(Math.random() * 100) + 1
	};
	res.writeHead(200, { "Content-Type": "application/lson" });
	res.end(JSON.stringify(response));
});

server.listen(3000, () => {
	console.log("SERVER_1 running on port 3000");
});
