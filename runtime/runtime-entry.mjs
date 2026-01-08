import './metrics/prometheus.mjs';
import { startMetricsServer } from './metrics/metrics-server.mjs';

process.env.PORT = process.env.PORT || '3000';
process.env.HOST = process.env.HOST || '0.0.0.0';

startMetricsServer();

process.on('uncaughtException', (err) => {
  console.error('[Runtime] Uncaught Exception:', err);
});

process.on('unhandledRejection', (reason, _promise) => {
  console.error('[Runtime] Unhandled Rejection:', reason);
});

try {
  await import('../server/entry.mjs');
  console.log('[Runtime] Servidor cargado.');
} catch (err) {
  console.error('[Runtime] Error cargando servidor:', err);
  process.exit(1);
}