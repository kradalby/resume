import prettier from 'eslint-plugin-prettier';

export default [
    {
        files: ['src/**/*.{js,ts}'],
        plugins: { prettier },
        rules: {
            'prettier/prettier': 'error',
        },
    },
];
