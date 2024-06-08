import request from 'supertest';
import app from '../index.js';

describe('API tests', () => {
  it('GET /number should return the number', async () => {
    const response = await request(app).get('/number');
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('number');
  });

  it('POST /increment should increment the number', async () => {
    const response = await request(app).post('/increment');
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('number');
  });

  it('POST /decrement should decrement the number', async () => {
    const response = await request(app).post('/decrement');
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('number');
  });
});
