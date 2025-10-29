import { useEffect, useState } from 'react';

export default function ThemeToggle() {
  const [dark, setDark] = useState(() => document.documentElement.classList.contains('dark'));

  useEffect(() => {
    if (dark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [dark]);

  return (
    <button
      onClick={() => setDark(v => !v)}
      className="px-3 py-1 rounded-md bg-brand-peach text-black dark:bg-brand-greenDark dark:text-white border border-black/10"
      aria-label="Cambiar tema"
    >
      {dark ? 'Modo claro' : 'Modo oscuro'}
    </button>
  );
}
