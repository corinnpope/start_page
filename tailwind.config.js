const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: ["./app/**/*.{html,js,erb}"],
      theme: {
         extend: {
          fontFamily: {
            sans: ['Poppins', ...defaultTheme.fontFamily.sans]
          }
         }
      },
  plugins: [],
}
