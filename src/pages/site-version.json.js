import { BUILD_TIME, SITE_VERSION } from "../siteVersion.js";

export const prerender = true;

export function GET() {
  return new Response(
    JSON.stringify({
      version: SITE_VERSION,
      builtAt: BUILD_TIME,
    }),
    {
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Cache-Control": "no-store, max-age=0",
      },
    },
  );
}
