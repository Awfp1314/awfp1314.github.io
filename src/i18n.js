// 国际化配置
export const languages = {
  zh: 'zh',
  en: 'en'
};

export const defaultLang = 'zh';

export const ui = {
  zh: {
    'nav.home': '首页',
    'nav.blog': '博客',
    'nav.about': '关于',
    'blog.title': '博客归档',
    'blog.description': '探索技术世界，记录开发心得。',
    'blog.search': '搜索文章...',
    'home.description': '一名专注于 AI 应用开发的工程师，探索 LLM、MCP、Function Calling 等技术在实际项目中的应用。了解更多',
    'home.about': '关于我',
  },
  en: {
    'nav.home': 'Home',
    'nav.blog': 'Blog',
    'nav.about': 'About',
    'blog.title': 'Blog Archive',
    'blog.description': 'Explore the tech world, document development insights.',
    'blog.search': 'Search posts...',
    'home.description': 'An engineer focused on AI application development, exploring the application of technologies such as LLM, MCP, and Function Calling in real projects. Learn more',
    'home.about': 'about me',
  }
};

export function getLangFromUrl(url) {
  const [, lang] = url.pathname.split('/');
  if (lang in languages) return lang;
  return defaultLang;
}

export function useTranslations(lang) {
  return function t(key) {
    return ui[lang][key] || ui[defaultLang][key];
  }
}
