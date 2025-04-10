import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {

async function getNodeName() {
  const res = await fetch("/node-info");
  const json = await res.json();
  return json.node;
}

api.onPageChange(async () => {
  const isAdmin = window.location.pathname.startsWith("/admin");
  const existing = document.getElementById("discourse-node-info");

  if (isAdmin) {
    if (!existing) {
      const nodeName = await getNodeName();
      const nodeInfo = document.createElement("div");
      nodeInfo.id = "discourse-node-info";
      nodeInfo.className = "alert alert-info";
      nodeInfo.style.position = "fixed";
      nodeInfo.style.bottom = "1em";
      nodeInfo.style.right = "1em";
      nodeInfo.style.zIndex = "10000";
      nodeInfo.style.maxWidth = "300px";

      nodeInfo.textContent = `Node: ${nodeName}`;
      document.body.appendChild(nodeInfo);
    }
  } else {
    if (existing) {
      existing.remove();
    }
  }
});


});