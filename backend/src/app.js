import express from 'express';
import cors from 'cors';
import { apiRouter } from './routes/index.js';
import { errorHandler } from './middlewares/errorHandler.js';
import { notFound } from './middlewares/notFound.js';

const app = express();

app.use(cors({
  origin: [
    'https://jshop-kappa.vercel.app',
    'http://localhost:5173',
  ],
  credentials: true,
}));

app.use(express.json());
app.use('/api', apiRouter);
app.use(notFound);
app.use(errorHandler);

export { app };