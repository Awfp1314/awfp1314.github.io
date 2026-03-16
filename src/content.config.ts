// Import the glob loader
import { glob } from "astro/loaders";
// Import utilities from `astro:content`
import { z, defineCollection } from "astro:content";
// Define a `loader` and `schema` for each collection
const blog = defineCollection({
    loader: glob({ pattern: '**/[^_]*.mdx', base: "./src/blog/" }),
    schema: z.object({
      title: z.string(),
      pubDate: z.optional(z.string().date()),
      description: z.string(),
      author: z.string(),
      image: z.optional(z.string(), {
        url: z.string(),
        alt: z.string()
      }),
      tags: z.array(z.string())
    })
});
// Export a single `collections` object to register your collection(s)
export const collections = { blog };