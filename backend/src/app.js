import express from 'express';
import cors from 'cors';
import { apiRouter } from './routes/index.js';
import { errorHandler } from './middlewares/errorHandler.js';
import { notFound } from './middlewares/notFound.js';

const app = express();

app.use(cors({
  origin: true,
  credentials: true,
}));

app.use(express.json());

app.use('/api', apiRouter);

app.use(notFound);
app.use(errorHandler);

export { app };
