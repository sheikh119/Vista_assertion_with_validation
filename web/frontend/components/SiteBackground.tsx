import GridScan from "@/components/GridScan";

/**
 * Full-viewport ambient grid + scan used behind the home hero.
 * Props tuned for a softer moving highlight (less bloom / scan spread).
 */
export default function SiteBackground() {
  return (
    <div
      aria-hidden
      className="pointer-events-none fixed inset-0 -z-10 overflow-hidden"
    >
      <div className="absolute inset-0 opacity-[0.78]">
        <GridScan
          linesColor="#3b82f6"
          scanColor="#c084fc"
          gridScale={0.08}
          lineThickness={1.4}
          lineJitter={0.06}
          scanOpacity={0.62}
          scanGlow={1.0}
          scanSoftness={2.4}
          scanDuration={2.6}
          scanDelay={1.2}
          scanDirection="pingpong"
          noiseIntensity={0.015}
          bloomIntensity={0.72}
          bloomThreshold={0.18}
          bloomSmoothing={0.4}
          chromaticAberration={0.0025}
          enablePost
          sensitivity={0.45}
        />
      </div>
      <div
        className="absolute inset-0"
        style={{
          background:
            "linear-gradient(to bottom, rgba(10,11,20,0.15) 0%, rgba(10,11,20,0.55) 60%, rgba(10,11,20,0.92) 100%)",
        }}
      />
    </div>
  );
}
