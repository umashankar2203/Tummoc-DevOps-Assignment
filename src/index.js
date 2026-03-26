const express = require('express');
const client = require('prom-client');

const app = express();
const PORT = process.env.PORT || 3000;

client.collectDefaultMetrics();

app.get('/', (req, res) => {
  res.json({ message: 'Hello from the DevOps demo app!', status: 'ok' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', uptime: process.uptime() });
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = app;