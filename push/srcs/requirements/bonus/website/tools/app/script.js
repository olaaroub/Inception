function drawConnections() {
    const svg = document.getElementById('svg-canvas');
    const flowchart = document.getElementById('flowchart');
    // Clear previous lines
    svg.innerHTML = svg.querySelector('defs').outerHTML;

    if (window.innerWidth <= 900) return;

    const connections = [
        ['user', 'nginx'],
        ['nginx', 'wordpress'], ['nginx', 'adminer'], ['nginx', 'portainer'], ['nginx', 'website'],
        ['wordpress', 'mariadb'], ['wordpress', 'redis'],
        ['adminer', 'mariadb'],
        ['wordpress', 'wp-files'], ['ftp', 'wp-files'],
        ['mariadb', 'db-data']
    ];

    const flowchartRect = flowchart.getBoundingClientRect();

    connections.forEach(([fromId, toId]) => {
        const fromEl = document.getElementById(fromId);
        const toEl = document.getElementById(toId);
        if (!fromEl || !toEl) return;

        const fromRect = fromEl.getBoundingClientRect();
        const toRect = toEl.getBoundingClientRect();

        const x1 = (fromRect.left + fromRect.width / 2) - flowchartRect.left;
        const y1 = fromRect.bottom - flowchartRect.top;
        const x2 = (toRect.left + toRect.width / 2) - flowchartRect.left;
        const y2 = toRect.top - flowchartRect.top;

        const line = document.createElementNS('http://www.w3.org/2000/svg', 'path');
        const d = `M ${x1} ${y1} C ${x1} ${y1 + 40}, ${x2} ${y2 - 40}, ${x2} ${y2}`;
        line.setAttribute('d', d);
        line.setAttribute('class', 'connector-line');
        svg.appendChild(line);
    });
}

window.addEventListener('load', drawConnections);
window.addEventListener('resize', drawConnections);