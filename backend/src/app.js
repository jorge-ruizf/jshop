import express from 'express';
import cors from 'cors';
import { apiRouter } from './routes/index.js';
import { errorHandler } from './middlewares/errorHandler.js';
import { notFound } from './middlewares/notFound.js';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();

app.use(cors({
  origin: true,
  credentials: true,
}));

app.use(express.json());

const __dirname = path.dirname(fileURLToPath(import.meta.url));
app.use('/imgs', express.static(path.join(__dirname, 'public/imgs')));

app.use('/api', apiRouter);

app.use(notFound);
app.use(errorHandler);

export { app };
