import { defineEcConfig } from 'astro-expressive-code'
import { pluginLineNumbers } from '@expressive-code/plugin-line-numbers'

export default defineEcConfig({
  themes: ['material-theme-lighter', 'kanagawa-dragon'],
  plugins: [pluginLineNumbers()],
});
