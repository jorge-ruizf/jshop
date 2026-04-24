export function requireFields(fields) {
  return (req, res, next) => {
    if (!req.body || typeof req.body !== 'object') {
      return res.status(400).json({ error: { message: 'Request body must be a JSON object' } });
    }
    const missing = fields.filter((f) => req.body[f] === undefined || req.body[f] === null || req.body[f] === '');
    if (missing.length > 0) {
      return res.status(400).json({ error: { message: `Missing required fields: ${missing.join(', ')}` } });
    }
    next();
  };
}

export function parseId(req, res, next) {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id <= 0) {
    return res.status(400).json({ error: { message: 'Invalid id parameter' } });
  }
  req.id = id;
  next();
}
