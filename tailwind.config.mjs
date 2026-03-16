/** @type {import('tailwindcss').Config} */
import defaultTheme from 'tailwindcss/defaultTheme'

export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: ['class'],
	theme: {
    extend: {
      fontFamily: {
        sans: ['Jetbrains Mono', ...defaultTheme.fontFamily.sans],
        // sans: ['Noto Sans', ...defaultTheme.fontFamily.sans],
        mono: ['JetBrains Mono', ...defaultTheme.fontFamily.mono],
      },
      colors: {
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        additive: {
          DEFAULT: 'hsl(var(--additive))',
          foreground: 'hsl(var(--additive-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        border: 'hsl(var(--border))',
        ring: 'hsl(var(--ring))',
      },
    },
  },
	plugins: [require('@tailwindcss/typography')],
}


/*
theme: {
		extend: {
			colors: {
				'color-1': '#141415',
				'color-2': '#2E2E2E',
				'color-3': '#BABDBE',
				'color-4': '#D9D9D9',
				'color-5': '#E8E8E8',
			},
			fontFamily: {
        electrolize: ['Electrolize', 'sans-serif'],
				robotomono:  ['Roboto Mono', 'sans-serif']
      },
		},
	},
 */