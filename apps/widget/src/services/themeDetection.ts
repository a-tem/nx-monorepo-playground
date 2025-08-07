const THEME_KEY = 'theme';
export type ThemeMode = 'dark' | 'light';

export const detectTheme = () => {
  if (localStorage.getItem(THEME_KEY)) {
    return localStorage.getItem(THEME_KEY) as ThemeMode;
  } else {
    if (typeof window === 'undefined') {
      return 'light';
    }
    const isDarkMode = window.matchMedia(
      '(prefers-color-scheme: dark)'
    ).matches;
    return isDarkMode ? 'dark' : 'light';
  }
};

export const setTheme = (theme: ThemeMode) => {
  localStorage.setItem(THEME_KEY, theme);
};
