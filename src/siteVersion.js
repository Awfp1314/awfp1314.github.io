export const SITE_VERSION =
  process.env.PUBLIC_SITE_VERSION ||
  process.env.GITHUB_SHA ||
  process.env.GITHUB_RUN_ID ||
  "local-dev";

export const BUILD_TIME =
  process.env.PUBLIC_SITE_VERSION || process.env.GITHUB_SHA || process.env.GITHUB_RUN_ID
    ? new Date().toISOString()
    : "local-dev";
