# PKIDemo
尝试使用对称加密、非对称加密、摘要、签名、口令加密、报文认证等算法。

1. 对称加密：使用CommonCrypt框架，验证key、iv长度，进行DES、AES、RC4加密。
2. 非对称加密：使用Security.framework，实现了RSA算法。
3. 数字摘要：使用CommonCrypt框架，实现了MD5、SHA1、SHA256
4. 数字签名：上述两个框架的结合，RSA私钥加签并验证。尚未验证是否正确。
5. 口令加密：PBE，使用MD5多次迭代，为口令加盐，产生密钥。加解密方法与对称加密相同。
6. 报文认证：HMac。

封装成category使用起来会更加方便些，但是这只是个demo，就没有实现category的封装。    
提供学习交流。其中肯定有很多写得不好的地方，后续学习到会修改。

· PKIActor文件夹中是各种算法的实现    
· PKIDemo是例程