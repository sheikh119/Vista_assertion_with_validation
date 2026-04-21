"use client";

import { CSSProperties, useId } from "react";
import { Activity, GraduationCap, ShieldCheck } from "lucide-react";
import { cn } from "@/lib/utils";
import "./ReflectiveCard.css";

type Tone = "brand" | "violet" | "teal";

export interface ReflectiveCardProps {
  /** Visible name on the card */
  name: string;
  /** Role / title */
  role?: string;
  /** Registration / ID number */
  regNumber: string;
  /** Institution, e.g. GIKI */
  institution?: string;
  /** Batch info, e.g. BATCH 32 */
  batch?: string;
  /** Faculty code, e.g. BSCE */
  faculty?: string;
  /** Optional photo URL (e.g. /images/abbas.png). Shown as a circular avatar;
   *  the metallic rippled background is omitted so the card uses a flat surface. */
  photo?: string;
  /** Optional bg image URL; if omitted a theme-coloured SVG is generated */
  backgroundImage?: string;
  /** Colour theme used when generating the SVG background */
  tone?: Tone;

  /** Metallic-filter knobs */
  blurStrength?: number;
  metalness?: number;
  roughness?: number;
  overlayColor?: string;
  displacementStrength?: number;
  noiseScale?: number;
  specularConstant?: number;
  grayscale?: number;
  glassDistortion?: number;
  color?: string;

  className?: string;
  style?: CSSProperties;
}

const TONE_COLOURS: Record<Tone, { a: string; b: string; c: string }> = {
  brand:  { a: "#0b1a33", b: "#1d4ed8", c: "#60a5fa" },
  violet: { a: "#160a30", b: "#6d28d9", c: "#a78bfa" },
  teal:   { a: "#06202b", b: "#0d9488", c: "#5eead4" },
};

/**
 * Build a self-contained SVG (as a data-URL) that encodes the student info
 * into the card background so it shows through the metallic distortion.
 */
function buildBackgroundSVG({
  name, regNumber, institution = "GIKI", batch, faculty, tone,
}: {
  name: string;
  regNumber: string;
  institution?: string;
  batch?: string;
  faculty?: string;
  tone: Tone;
}) {
  const c = TONE_COLOURS[tone];
  const up = name.toUpperCase();
  const regUp = `#${regNumber}`;
  const detail = [institution, faculty, batch].filter(Boolean).join(" · ");

  const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="640" height="880" viewBox="0 0 640 880">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%"  stop-color="${c.a}"/>
      <stop offset="60%" stop-color="${c.b}"/>
      <stop offset="100%" stop-color="${c.c}"/>
    </linearGradient>
    <pattern id="grid" width="40" height="40" patternUnits="userSpaceOnUse">
      <path d="M 40 0 L 0 0 0 40" fill="none"
            stroke="rgba(255,255,255,0.10)" stroke-width="1"/>
    </pattern>
    <radialGradient id="spot" cx="30%" cy="22%" r="55%">
      <stop offset="0%"  stop-color="rgba(255,255,255,0.45)"/>
      <stop offset="100%" stop-color="rgba(255,255,255,0)"/>
    </radialGradient>
  </defs>

  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#grid)"/>
  <rect width="100%" height="100%" fill="url(#spot)"/>

  <!-- Large faded repeated text pattern with the institution + batch -->
  <g font-family="Inter, ui-sans-serif, system-ui"
     font-weight="800" fill="rgba(255,255,255,0.07)"
     letter-spacing="6">
    <text x="-40" y="110"  font-size="46">${detail}  ${detail}</text>
    <text x="-80" y="250"  font-size="46">${detail}  ${detail}</text>
    <text x="-40" y="390"  font-size="46">${detail}  ${detail}</text>
    <text x="-80" y="530"  font-size="46">${detail}  ${detail}</text>
    <text x="-40" y="670"  font-size="46">${detail}  ${detail}</text>
    <text x="-80" y="810"  font-size="46">${detail}  ${detail}</text>
  </g>

  <!-- Centered large name watermark -->
  <g font-family="Inter, ui-sans-serif, system-ui" text-anchor="middle">
    <text x="320" y="440" font-size="62" font-weight="900"
          fill="rgba(255,255,255,0.14)" letter-spacing="4">${up}</text>
    <text x="320" y="490" font-size="28" font-weight="700"
          fill="rgba(255,255,255,0.18)" letter-spacing="8">${regUp}</text>
  </g>

  <!-- Diagonal slashes for an identity-card / circuit feel -->
  <g stroke="rgba(255,255,255,0.08)" stroke-width="2" fill="none">
    <path d="M -40,680 L 680,60" />
    <path d="M -40,740 L 680,120" />
    <path d="M -40,800 L 680,180" />
  </g>
</svg>`.trim();

  return `data:image/svg+xml;utf8,${encodeURIComponent(svg)}`;
}

export default function ReflectiveCard({
  name,
  role,
  regNumber,
  institution = "GIKI",
  batch = "BATCH 32",
  faculty = "BSCE",
  photo,
  backgroundImage,
  tone = "brand",

  blurStrength = 8,
  color = "#ffffff",
  metalness = 1,
  roughness = 0.55,
  overlayColor = "rgba(10, 12, 24, 0.35)",
  displacementStrength = 16,
  noiseScale = 1.1,
  specularConstant = 4.0,
  grayscale = 0.1,
  glassDistortion = 22,
  className = "",
  style = {},
}: ReflectiveCardProps) {
  // Unique filter ID per instance (avoids clashes between multiple cards)
  const uid = useId().replace(/:/g, "");
  const filterId = `rc_filter_${uid}`;

  const baseFrequency = 0.03 / Math.max(0.1, noiseScale);
  const saturation = 1 - Math.max(0, Math.min(1, grayscale));

  /** When a photo is shown in the avatar, skip the rippled photo background. */
  const plainCard = Boolean(photo);

  const bgUrl =
    plainCard
      ? null
      : (backgroundImage ??
        buildBackgroundSVG({ name, regNumber, institution, batch, faculty, tone }));

  const plainSurface = plainCard
    ? `linear-gradient(165deg, ${TONE_COLOURS[tone].a} 0%, #12131f 45%, #0f1020 100%)`
    : undefined;

  const cssVars: CSSProperties = {
    // @ts-expect-error — CSS custom props
    "--blur-strength": `${blurStrength}px`,
    "--metalness": metalness,
    "--roughness": roughness,
    "--overlay-color": overlayColor,
    "--text-color": color,
    "--saturation": saturation,
  };

  return (
    <div
      className={cn(
        "reflective-card-container",
        plainCard && "reflective-card-container--plain",
        className,
      )}
      style={{ ...style, ...cssVars }}
    >
      {!plainCard && (
        <svg className="reflective-svg-filters" aria-hidden="true">
          <defs>
            <filter id={filterId} x="-20%" y="-20%" width="140%" height="140%">
              <feTurbulence
                type="turbulence"
                baseFrequency={baseFrequency}
                numOctaves={2}
                result="noise"
              />
              <feColorMatrix in="noise" type="luminanceToAlpha" result="noiseAlpha" />
              <feDisplacementMap
                in="SourceGraphic"
                in2="noise"
                scale={displacementStrength}
                xChannelSelector="R"
                yChannelSelector="G"
                result="rippled"
              />
              <feSpecularLighting
                in="noiseAlpha"
                surfaceScale={displacementStrength}
                specularConstant={specularConstant}
                specularExponent={20}
                lightingColor="#ffffff"
                result="light"
              >
                <fePointLight x="0" y="0" z="300" />
              </feSpecularLighting>
              <feComposite
                in="light"
                in2="rippled"
                operator="in"
                result="light-effect"
              />
              <feBlend
                in="light-effect"
                in2="rippled"
                mode="screen"
                result="metallic-result"
              />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 1 0"
                result="solidAlpha"
              />
              <feMorphology
                in="solidAlpha"
                operator="erode"
                radius={45}
                result="erodedAlpha"
              />
              <feGaussianBlur
                in="erodedAlpha"
                stdDeviation={10}
                result="blurredMap"
              />
              <feComponentTransfer in="blurredMap" result="glassMap">
                <feFuncA type="linear" slope={0.5} intercept={0} />
              </feComponentTransfer>
              <feDisplacementMap
                in="metallic-result"
                in2="glassMap"
                scale={glassDistortion}
                xChannelSelector="A"
                yChannelSelector="A"
                result="final"
              />
            </filter>
          </defs>
        </svg>
      )}

      {plainCard ? (
        <div
          data-rc={uid}
          className="reflective-background reflective-background--plain"
          style={{ background: plainSurface }}
        />
      ) : (
        <div
          data-rc={uid}
          className="reflective-background"
          style={{
            backgroundImage: bgUrl ? `url("${bgUrl}")` : undefined,
            filter: bgUrl
              ? `saturate(${saturation}) contrast(120%) brightness(110%) blur(${blurStrength}px) url(#${filterId})`
              : undefined,
          }}
        />
      )}

      {!plainCard && (
        <>
          <div className="reflective-noise" />
          <div className="reflective-sheen" />
        </>
      )}
      <div className="reflective-border" />

      <div
        className={cn(
          "reflective-content",
          plainCard && "reflective-content--plain",
        )}
      >
        {/* Header */}
        <div className="rc-header">
          <span className="rc-badge">
            <ShieldCheck size={13} />
            STUDENT ID
          </span>
          <Activity size={18} className="rc-status" />
        </div>

        {/* Body */}
        <div className="rc-body">
          {photo && (
            <div className={`rc-avatar rc-avatar--${tone}`}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={photo} alt={name} />
            </div>
          )}
          <div>
            <h2 className="rc-name">{name.toUpperCase()}</h2>
            {role && <p className="rc-role">{role}</p>}
          </div>
          <div className="rc-tags">
            <span className="rc-tag">{institution}</span>
            <span className="rc-tag">{faculty}</span>
            <span className="rc-tag">{batch}</span>
          </div>
        </div>

        {/* Footer */}
        <div className="rc-footer">
          <div className="rc-id-section">
            <span className="rc-label">Reg. Number</span>
            <span className="rc-value">{regNumber}</span>
          </div>
          <div className="rc-inst-section">
            <GraduationCap size={26} className="rc-inst-icon" />
          </div>
        </div>
      </div>
    </div>
  );
}
