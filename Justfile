default:
    @just --list

setup:
    npm install

test:
    npm test

lint:
    npx eslint .
