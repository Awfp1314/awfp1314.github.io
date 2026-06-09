export const ui = {
  zh: {
    blogTitle: '博客归档',
    blogDescription: '探索技术世界，记录开发心得。',
    blogSearch: '搜索文章...',
    backToBlog: '返回博客列表',
  },
  en: {
    blogTitle: 'Blog Archive',
    blogDescription: 'Explore the tech world, document development insights.',
    blogSearch: 'Search posts...',
    backToBlog: 'Back to Blog',
  },
};

export function getLangFromPath(pathname) {
  return pathname.includes('/index-en') || pathname.includes('/about-en') ? 'en' : 'zh';
}
