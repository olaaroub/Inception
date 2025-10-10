<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inception - Docker Infrastructure</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            overflow-x: hidden;
        }

        .container {
            max-width: 1200px;
            padding: 40px;
            text-align: center;
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            animation: slideDown 0.8s ease-out;
        }

        @keyframes slideDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .tagline {
            font-size: 1.5rem;
            margin-bottom: 40px;
            opacity: 0.9;
            animation: fadeIn 1.2s ease-in;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }

        .service-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            animation: scaleIn 0.6s ease-out backwards;
        }

        .service-card:nth-child(1) { animation-delay: 0.2s; }
        .service-card:nth-child(2) { animation-delay: 0.4s; }
        .service-card:nth-child(3) { animation-delay: 0.6s; }

        @keyframes scaleIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .service-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .service-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .service-card h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #fff;
        }

        .service-card p {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(16, 185, 129, 0.2);
            border: 1px solid rgba(16, 185, 129, 0.4);
            padding: 10px 20px;
            border-radius: 25px;
            margin: 30px 0;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        .status-dot {
            width: 10px;
            height: 10px;
            background: #10b981;
            border-radius: 50%;
            animation: blink 1.5s infinite;
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        .tech-stack {
            margin-top: 50px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }

        .tech-stack h2 {
            margin-bottom: 20px;
            font-size: 2rem;
        }

        .tech-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }

        .tech-tag {
            background: rgba(255, 255, 255, 0.15);
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 0.9rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .tech-tag:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }

        .cta-button {
            display: inline-block;
            margin-top: 30px;
            padding: 15px 40px;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid #fff;
            border-radius: 50px;
            color: #fff;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .cta-button:hover {
            background: #fff;
            color: #667eea;
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(255,255,255,0.3);
        }

        .footer {
            margin-top: 50px;
            font-size: 0.9rem;
            opacity: 0.7;
        }

        @media (max-width: 768px) {
            h1 { font-size: 2.5rem; }
            .tagline { font-size: 1.2rem; }
            .services-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Inception</h1>
        <p class="tagline">Containerized Infrastructure with Docker Compose</p>

        <div class="status-badge">
            <span class="status-dot"></span>
            <span>All Services Running</span>
        </div>

        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon">🌐</div>
                <h3>Nginx</h3>
                <p>High-performance web server with TLSv1.2/1.3 encryption serving on port 443</p>
            </div>

            <div class="service-card">
                <div class="service-icon">📝</div>
                <h3>WordPress</h3>
                <p>PHP 8.2 powered CMS with WP-CLI, Redis caching, and custom configurations</p>
            </div>

            <div class="service-card">
                <div class="service-icon">🗄️</div>
                <h3>MariaDB</h3>
                <p>Robust MySQL-compatible database for persistent data storage</p>
            </div>
        </div>

        <div class="tech-stack">
            <h2>⚡ Technology Stack</h2>
            <div class="tech-tags">
                <span class="tech-tag">🐳 Docker</span>
                <span class="tech-tag">📦 Docker Compose</span>
                <span class="tech-tag">🔒 SSL/TLS</span>
                <span class="tech-tag">⚡ Redis Cache</span>
                <span class="tech-tag">🐧 Debian Bullseye</span>
                <span class="tech-tag">🐘 PHP 8.2</span>
                <span class="tech-tag">🌐 Nginx 1.18</span>
                <span class="tech-tag">🗃️ MariaDB 10.5</span>
                <span class="tech-tag">📱 WordPress 6.8</span>
            </div>
        </div>

        <a href="/wp-admin" class="cta-button">Access WordPress Dashboard →</a>

        <div class="footer">
            <p>Built with ❤️ by olaaroub | 42 Network Inception Project</p>
            <p style="margin-top: 10px; font-size: 0.8rem;">
                <?php echo date('Y'); ?> • Server: <?php echo gethostname(); ?> • PHP: <?php echo phpversion(); ?>
            </p>
        </div>
    </div>

    <script>
        // Add subtle parallax effect on mouse move
        document.addEventListener('mousemove', (e) => {
            const cards = document.querySelectorAll('.service-card');
            const x = e.clientX / window.innerWidth;
            const y = e.clientY / window.innerHeight;

            cards.forEach((card, index) => {
                const speed = (index + 1) * 2;
                card.style.transform = `
                    translateX(${x * speed}px)
                    translateY(${y * speed}px)
                `;
            });
        });

        // Console easter egg
        console.log('%c🚀 Inception Project', 'font-size: 20px; font-weight: bold; color: #667eea;');
        console.log('%cBuilt with Docker Compose', 'font-size: 14px; color: #764ba2;');
        console.log('%c\nServices:\n- Nginx (Web Server)\n- WordPress (CMS)\n- MariaDB (Database)\n- Redis (Cache)', 'color: #10b981;');
    </script>
</body>
</html>
