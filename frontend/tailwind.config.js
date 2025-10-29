/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class',
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        // Paleta del manual de identidad
        brand: {
          peach: '#ffbd29', // Durazno (energía)
          greenLight: '#7ed957',
          greenDark: '#094a24',
          green: '#4caf50',
          white: '#FFFFFF',
        },
        primary: {
          DEFAULT: '#4caf50',
          dark: '#094a24',
          light: '#7ed957',
        },
        secondary: {
          DEFAULT: '#ffbd29',
        },
        background: '#ffffff',
        foreground: '#0f172a',
      },
      fontFamily: {
        sans: ['Montserrat', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
};