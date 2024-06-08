// jest.config.cjs
module.exports = {
  transform: {
      '^.+\\.js$': 'babel-jest',
  },
  testEnvironment: 'node',
  moduleNameMapper: {
      '^(\\.{1,2}/.*)\\.js$': '$1',
  },
};