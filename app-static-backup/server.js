import express from "express";
const app = express();

app.get("/health", (_, res) => res.json({ status: "ok" }));

// Serve the Threat Composer build
app.use(express.static("build/browser-extension"));

app.listen(80, () => console.log("✅ Listening on http://localhost"));
