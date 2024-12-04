import Carousel from "@/components/carousel";
import CategoryCards from "@/components/categorycard";

export default function HomePage() {
  return (
    <main>
      <div className=" mx-auto opacity-90">
        <Carousel />
      </div>
      <div>
        <CategoryCards />
      </div>
    </main>
  );
}
