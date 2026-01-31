import { defineConfig } from 'vitest/config';

export default defineConfig({
    test: {
        include: ['tests/**/*_test.res.mjs'],
        watch: false
    }
})