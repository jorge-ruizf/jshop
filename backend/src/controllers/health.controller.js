import { checkHealth } from '../services/health.service.js';

export function getHealth(req, res) {
  res.json(checkHealth());
}
