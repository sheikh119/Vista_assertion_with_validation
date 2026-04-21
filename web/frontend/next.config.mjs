/** @type {import('next').NextConfig} */
/**
 * Next rewrites run on the server. Use VISTA_API_INTERNAL_URL in Docker
 * (e.g. http://backend:8000). Local dev: omit it and use localhost.
 */
const BACKEND =
  process.env.VISTA_API_INTERNAL_URL ??
  process.env.NEXT_PUBLIC_VISTA_API ??
  "http://localhost:8000";

const nextConfig = {
  reactStrictMode: true,
  output: "standalone",
  async rewrites() {
    return [
      {
        source: "/api/:path*",
        destination: `${BACKEND}/api/:path*`,
      },
    ];
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
        path: false,
        crypto: false,
        encoding: false,
      };
    }
    return config;
  },
};

export default nextConfig;
