export const REF_URL = "blog.hutao667.in";

export const SOCIALS = [
  { href: 'https://github.com/Awfp1314', label: 'Github' },
  { href: 'https://space.bilibili.com/1829900666', label: 'Bilibili' },
]

export const NAV_LINKS = {
  zh: [
    { href: '/', label: '首页'},
    { href: '/blog', label: '博客'},
    { href: '/about', label: '关于'},
  ],
  en: [
    { href: '/index-en', label: 'Home'},
    { href: '/blog', label: 'Blog'},
    { href: '/about-en', label: 'About'},
  ]
}

export const HOME_LINKS = [
  { href: '/blog', label: '博客' },
  ...SOCIALS,
]

export function withRef(href) {
  if (!href || href.startsWith('/') || href.startsWith('#') || href.startsWith('mailto:') || href.startsWith('tel:')) {
    return href;
  }

  try {
    const url = new URL(href);
    url.searchParams.set('ref', REF_URL);
    return url.toString();
  } catch {
    const separator = href.includes('?') ? '&' : '?';
    return `${href}${separator}ref=${encodeURIComponent(REF_URL)}`;
  }
}
