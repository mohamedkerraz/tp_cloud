import pgp from 'pg-promise';

const db = pgp("postgres://admin:root@localhost:5432/mydatabase");

export default db;
