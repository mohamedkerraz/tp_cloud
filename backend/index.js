import express from 'express';
import { PrismaClient } from '@prisma/client';
import cors from 'cors';

const app = express();
const prisma = new PrismaClient();
const port = process.env.PORT || 3000;

const corsOptions = {
  origin: 'http://localhost:5173',
};
app.use(cors(corsOptions));

prisma.$connect()
  .then(() => console.log('Connected to the database'))
  .catch((error) => {
    console.error('Error connecting to the database', error);
    process.exit(1);
  });

app.use(express.json());

app.get('/number', async (req, res) => {
  try {
    const number = await prisma.number.findFirst();
    res.json(number);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while fetching the number.' });
  }
});

app.post('/increment', async (req, res) => {
  try {
    let number = await prisma.number.findFirst();
    if (number) {
      number = await prisma.number.update({
        where: { id: number.id },
        data: { number: number.number + 1 },
      });
    } else {
      number = await prisma.number.create({ data: { number: 1 } });
    }
    res.json(number);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while incrementing the number.' });
  }
});


app.post('/decrement', async (req, res) => {
  try {
    let number = await prisma.number.findFirst();
    if (number) {
      number = await prisma.number.update({
        where: { id: number.id },
        data: { number: number.number - 1 },
      });
    } else {
      number = await prisma.number.create({ data: { number: -1 } });
    }
    res.json(number);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while incrementing the number.' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

export default app;
