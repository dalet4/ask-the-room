import assert from 'node:assert/strict';
import fs from 'node:fs';
import vm from 'node:vm';
const source=fs.readFileSync(new URL('./display/index.html',import.meta.url),'utf8');
new vm.Script(source.match(/<script>([\s\S]*?)<\/script>/)[1]);
const flow=JSON.parse(fs.readFileSync(new URL('./n8n/answer-the-room-demo-safe.json',import.meta.url)));
const map=flow.nodes.find(n=>n.id==='map').parameters.jsCode;
const result=vm.runInNewContext(`(()=>{${map}})()`,{
 $:()=>({first:()=>({json:{questions:[{id:1},{id:2}]}})}),
 $input:{first:()=>({json:{choices:[{message:{content:JSON.stringify({answers:[{id:1,answer:'one'},{id:2,answer:'two'},{id:999,answer:'wrong row'},{id:1,answer:'duplicate'}]})}}]}})}
});
assert.deepEqual(Array.from(result,r=>r.json.id),['1','2']);
assert.equal(flow.nodes.find(n=>n.id==='save').type,'n8n-nodes-base.httpRequest');
console.log('PASS: display syntax and safe per-row answer matching');
