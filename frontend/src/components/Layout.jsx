import ThemeToggle from './ThemeToggle';

export default function Layout({ children }) {
  return (
    <div className="min-h-screen bg-background text-foreground dark:bg-[#0b1b12] dark:text-white transition-colors">
      <header className="sticky top-0 z-20 bg-white/80 dark:bg-[#0f2419]/80 backdrop-blur border-b">
        <div className="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-full bg-brand-peach" />
            <span className="font-semibold">GooTrans Hacaritama</span>
          </div>
          <nav className="flex items-center gap-3">
            <ThemeToggle />
          </nav>
        </div>
      </header>
      <main className="max-w-6xl mx-auto px-4 py-6">
        {children}
      </main>
      <footer className="border-t py-4 text-center text-sm opacity-70">© {new Date().getFullYear()} Hacaritama</footer>
    </div>
  );
}
