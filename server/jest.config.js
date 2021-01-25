module.exports = {
  preset: 'ts-jest/presets/js-with-ts',
  testMatch: [
    "**/tests/**/*.+(ts|tsx|js)",
    "**/?(*.)+(spec|test).+(ts|tsx|js)"
  ],
  testEnvironment: 'node',
  coveragePathIgnorePatterns: [
    "/node_modules/"
  ]
};