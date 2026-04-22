// React 组件示例
// 展示如何在 Astro 项目中使用 React 组件

import { useState, useEffect } from 'react';

interface SearchBarProps {
  placeholder?: string;
  onSearch?: (query: string) => void;
  className?: string;
}

export default function SearchBar({ 
  placeholder = '搜索...', 
  onSearch,
  className = '' 
}: SearchBarProps) {
  const [query, setQuery] = useState('');
  const [isFocused, setIsFocused] = useState(false);

  // 处理搜索
  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (onSearch && query.trim()) {
      onSearch(query.trim());
    }
  };

  // 处理输入变化
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setQuery(e.target.value);
  };

  // 清除搜索
  const handleClear = () => {
    setQuery('');
    if (onSearch) {
      onSearch('');
    }
  };

  // 键盘快捷键
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Ctrl/Cmd + K 聚焦搜索框
      if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
        e.preventDefault();
        document.getElementById('search-input')?.focus();
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []);

  return (
    <form 
      onSubmit={handleSearch}
      className={`relative ${className}`}
    >
      {/* 搜索图标 */}
      <div className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">
        <svg 
          className="size-5" 
          fill="none" 
          stroke="currentColor" 
          viewBox="0 0 24 24"
        >
          <path 
            strokeLinecap="round" 
            strokeLinejoin="round" 
            strokeWidth={2} 
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" 
          />
        </svg>
      </div>

      {/* 输入框 */}
      <input
        id="search-input"
        type="text"
        value={query}
        onChange={handleChange}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
        placeholder={placeholder}
        className={`
          w-full pl-10 pr-10 py-2 
          rounded-lg border border-border
          bg-background text-foreground
          placeholder:text-muted-foreground
          focus:outline-none focus:ring-2 focus:ring-primary
          transition-all
          ${isFocused ? 'border-primary' : ''}
        `}
      />

      {/* 清除按钮 */}
      {query && (
        <button
          type="button"
          onClick={handleClear}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
          aria-label="清除搜索"
        >
          <svg 
            className="size-5" 
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path 
              strokeLinecap="round" 
              strokeLinejoin="round" 
              strokeWidth={2} 
              d="M6 18L18 6M6 6l12 12" 
            />
          </svg>
        </button>
      )}

      {/* 快捷键提示 */}
      {!isFocused && !query && (
        <div className="absolute right-3 top-1/2 -translate-y-1/2 text-xs text-muted-foreground">
          <kbd className="px-2 py-1 rounded bg-muted">⌘K</kbd>
        </div>
      )}
    </form>
  );
}
