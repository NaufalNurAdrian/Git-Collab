import Link from 'next/link';

export default function Sidebar () {
  return (
    <div className="bg-nobel h-screen w-40 p-5">
      <div className="text-xl font-bold mb-8">
        FestifyTix
        </div>
      <div>
        <div className="mb-4">
          <Link href="/dashboard" className="hover:text-white">
            Dashboard
          </Link>
        </div>
        <div className="mb-4">
          <Link href="/dashboard/eventsaya" className="hover:text-white">
            Event Saya
          </Link>
        </div>
        <div className="mb-4">
          <Link href="/settings" className="hover:text-white">
            Pengaturan
          </Link>
        </div>
        <div className="mb-4">
          <Link href="/accounts" className="hover:text-white">
            Informasi Legal
          </Link>
        </div>
      </div>
    </div>
  );
};