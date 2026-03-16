// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import mdx from '@astrojs/mdx';
import react from '@astrojs/react';

import expressiveCode from 'astro-expressive-code';

// https://astro.build/config
export default defineConfig({
  site: 'https://awfp1314.github.io/',
  base: '/HUTAO667.github.io',
  integrations: [tailwind({
    applyBaseStyles: false,
  }), expressiveCode({
      themes: ['material-theme-lighter', 'kanagawa-dragon']
  }), mdx(), react()],
  trailingSlash: 'ignore',
  server: {
    port: 4321,
    host: "0.0.0.0"
  },
  devToolbar: {
    enabled: false,
  },
});