const http = require('http');
const { exec } = require('child_process');

const server = http.createServer((req, res) => {
	const cmd = 'hostname && uptime && lsb_release -d';
	exec (cmd, (error, stdout, stderr) => {
		const response = {
			stdout: stdout.trim(), 
			stderr: stderr.trim(),
			timestamp: new Date().toISOString()
		};
		res.writeHead(200, { 'Content-Type': 'application/json' });
		res.end(JSON.stringify(response, null, 2));
	});
});

server.listen(4000, () => {
	console.log('SERVER_2 running on port 4000');
});
