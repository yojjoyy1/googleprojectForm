const apn = require("apn");
// token 数组
let tokens = ["d4f8b7ec2c10c064db9c367b5e67b4ae093befde6d61f14b6d7f3c9dfd174c73"]; //获取的token
let service = new apn.Provider({
    production: false,
    cert: "./dev_cert.pem",
    key: "./dev_key.pem",
    // gateway: "gateway.sandbox.push.apple.com",
    // gateway: "gateway.push.apple.com"; 线上地址  port: 2195, 端口
    // passphrase: "eSER!@#45" //pem证书密码 
});
let note = new apn.Notification();
// 主题 一般取应用标识符（bundle identifier）
note.topic = "water.project.googleApp"
note.alert = "hello"
console.log(`Sending: ${note.compile()} to ${tokens}`);
service.send(note, tokens).then( result => {
console.log("sent:", result.sent.length);
console.log("failed:", result.failed.length);
  console.log(result.failed);
});
service.shutdown();