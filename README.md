# LeadWire 🔌
### Wiring Harness Sales Lead Dashboard

> เครื่องมือจัดการ Lead สำหรับ Sales ธุรกิจชุดสายไฟ พร้อม Lead Scoring, Lead Value และ Odoo CRM Sync

---

## ✨ Features

- 📊 **Lead Scoring** — คะแนน 0–100 จาก 4 มิติ (ขนาดบริษัท, มูลค่า, ศักยภาพ, กลยุทธ์)
- 🏆 **Lead Level** — ระดับ S / A / B / C / D  
- 💰 **Lead Value** — มูลค่า Lead เป็นบาท
- 🔗 **Odoo CRM Sync** — ติดตามว่า Lead ไหน Sync เข้า Odoo แล้ว
- 📧 **Cold Email** — ส่ง Email หาลูกค้าเป้าหมาย
- 📁 **CSV Export** — Export ข้อมูลเปิดใน Excel (รองรับภาษาไทย)
- 🌓 **Dark / Light Mode**
- 📈 **Analytics Charts** — สถิติ Lead ตามอุตสาหกรรม, ช่องทาง, คะแนน

## 🚀 การใช้งาน

**ไม่ต้องติดตั้งอะไรทั้งสิ้น** — เพียงเปิดไฟล์ `index.html` ในเบราว์เซอร์:

```bash
# Windows
start index.html

# หรือ double-click ไฟล์ใน Explorer
```

## 📁 โครงสร้างไฟล์

```
Leadwire/
├── CLAUDE.md                 # Context สำหรับ Claude Code AI
├── README.md                 # ไฟล์นี้
├── index.html                # แอปพลิเคชันหลัก (Single-file)
└── wiring_harness_leads.csv  # ฐานข้อมูล Lead (สำรอง/Export)
```

## 🎯 อุตสาหกรรมเป้าหมาย

| อุตสาหกรรม | ตัวย่อ |
|------------|--------|
| Automotive | รถยนต์ |
| Special Purpose Vehicle | SPV |
| Home Appliance | เครื่องใช้ไฟฟ้า |
| Industrial | อุตสาหกรรม |
| Agricultural Machinery | เครื่องจักรการเกษตร |

## 📡 ช่องทางการขาย

- **OEM** — ผู้ผลิตชิ้นส่วนดั้งเดิม
- **Aftermarket Replacement** — อะไหล่ทดแทน
- **Aftermarket Upgrade** — อัพเกรดประสิทธิภาพ
- **Repair Shop** — อู่ซ่อม
- **Online Seller** — ขายออนไลน์

## 🛠 Tech Stack

- HTML5 + CSS3 + Vanilla JavaScript
- Chart.js (CDN)
- Google Fonts: Inter + Outfit
- **ไม่มี** npm / build step / framework

---

> 📝 สร้างด้วย Antigravity AI | สำหรับ Lead Database ก่อน Sync เข้า Odoo CRM
