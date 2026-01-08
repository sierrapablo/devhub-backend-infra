import http from "node:http";

const PORT = Number(process.env.PORT || 3000);
const HOST = process.env.HOST || "0.0.0.0";

const server = http.createServer((req, res) => {
  if (req.method === "GET" && req.url === "/health") {
    res.statusCode = 200;
    res.setHeader("content-type", "application/json");
    res.end(
      JSON.stringify({
        status: "ok",
      })
    );
    return;
  }

  res.statusCode = 404;
  res.setHeader("content-type", "application/json");
  res.end(JSON.stringify({ error: "not_found" }));
});

server.listen(PORT, HOST, () => {
  console.log(`[Server] listening on ${HOST}:${PORT}`);
});

process.on("SIGTERM", () => {
  console.log("[Server] SIGTERM received, shutting down");
  server.close(() => process.exit(0));
});
