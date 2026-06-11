# LeadWire — Wiring Harness Sales Lead Dashboard

## Project Overview

**LeadWire** เป็น Single-File HTML Dashboard สำหรับ Sales ธุรกิจชุดสายไฟ (Wiring Harness) ใช้สำหรับ:
- เก็บและจัดการ **Lead** ลูกค้าที่เป็นเป้าหมาย
- ให้คะแนน Lead (Lead Scoring) ตามเกณฑ์ 4 มิติ
- ประเมินมูลค่า Lead (Lead Value) เป็นบาท
- ติดตามว่า Lead ไหนถูก Sync เข้า **Odoo CRM** แล้ว
- ส่ง Cold Email ออกไปยัง Lead
- Export ข้อมูลเป็น CSV เปิดใน Excel

โปรเจกต์นี้ **ไม่ใช่ CRM** — ไม่มี Pipeline, ไม่มีขั้นตอนการขาย, ไม่มีแผนปิดยอด  
เป็นเพียง Lead Database + Scoring + Sync กับ Odoo CRM ภายนอก

---

## Project Files

```
Leadwire/
├── CLAUDE.md                    # This file — Claude Code context
├── index.html                   # Main application (single HTML file, ~193KB)
├── index.html.html              # Backup/original copy (same content)
├── dashboard.html.bz2           # Compressed backup of older version
└── wiring_harness_leads.csv     # Lead database (UTF-8 BOM for Excel)
```

---

## Tech Stack

- **Pure HTML + CSS + JavaScript** — Zero build step, Zero dependencies (except CDN)
- **Chart.js** (CDN) — for analytics charts
- **Google Fonts** — Inter + Outfit via CDN
- **No framework, no npm, no bundler**

To open: just double-click `index.html` in Windows Explorer, or open in any browser.

---

## Application Architecture

### Single-File Design
Everything is in `index.html`:
- All CSS inside `<style>` block (with CSS Variables for dark/light theme)
- All JS inside `<script>` block at bottom
- All lead data is embedded as `const initialLeads = [...]` array in JS
- CSV (`wiring_harness_leads.csv`) is a supplementary export file, not used by the app at runtime

### Data Model — Lead Object
Each lead in `initialLeads[]` has these fields:
```javascript
{
  id: 1,
  companyName: "บริษัท XYZ",
  location: "กรุงเทพ, ภาคกลาง",
  region: "ภาคกลาง",          // ภาคกลาง | ภาคตะวันออก | ภาคเหนือ | ภาคใต้ | ภาคตะวันออกเฉียงเหนือ
  industry: "Automotive",      // Automotive | SPV | Home Appliance | Industrial | Agricultural Machinery
  salesChannel: "OEM",         // OEM | Aftermarket Replacement | Aftermarket Upgrade | Repair Shop | Online Seller
  products: "Automotive Wiring Harness",
  contactPerson: "คุณสมชาย",
  email: "contact@company.com",
  phone: "02-xxx-xxxx",
  website: "https://...",
  crmSynced: false,            // true = ถูก Sync เข้า Odoo CRM แล้ว
  leadScore: 85,               // คะแนนรวม 0-100 (คำนวณจาก 4 มิติด้านล่าง)
  leadValue: 5000000,          // มูลค่า Lead เป็นบาท (ตัวเลข)
  certifications: "ISO 9001, IATF 16949",
  notes: "รายละเอียดเพิ่มเติม..."
}
```

### Lead Scoring System (คะแนนรวม 100 คะแนน)

#### 1. ขนาดบริษัท (25 คะแนน)
| ระดับ | คะแนน |
|-------|--------|
| OEM / บริษัทข้ามชาติ | 25 |
| บริษัทมหาชน / โรงงานใหญ่ | 20 |
| โรงงานขนาดกลาง | 15 |
| SME | 10 |
| รายเล็ก | 5 |

#### 2. มูลค่าซื้อขายต่อปี (35 คะแนน)
| มูลค่า | คะแนน |
|--------|--------|
| ≥ 10 ล้านบาท | 35 |
| 5–10 ล้านบาท | 25 |
| 1–5 ล้านบาท | 15 |
| 0.5–1 ล้านบาท | 10 |
| < 0.5 ล้านบาท | 5 |

#### 3. ศักยภาพการเติบโต (20 คะแนน)
| ระดับ | คะแนน |
|-------|--------|
| ขยายธุรกิจต่อเนื่อง | 20 |
| มีแผนลงทุนใหม่ | 15 |
| ธุรกิจคงที่ | 10 |
| แนวโน้มลดลง | 5 |

#### 4. ความสำคัญเชิงกลยุทธ์ (20 คะแนน)
| ระดับ | คะแนน |
|-------|--------|
| เป็นลูกค้าอ้างอิง / เปิดตลาดใหม่ | 20 |
| ช่วยเพิ่ม Market Share | 15 |
| ลูกค้าทั่วไป | 10 |
| ความสำคัญต่ำ | 5 |

### Lead Level Badge (ระดับ Lead)
| คะแนน | ระดับ | สี |
|--------|-------|-----|
| 85–100 | S | สีทอง |
| 70–84 | A | สีม่วง (primary) |
| 55–69 | B | สีเขียว-น้ำเงิน (teal/accent) |
| 40–54 | C | สีส้ม |
| < 40 | D | สีเทา |

---

## Key Features

### Lead Management
- **CRUD**: Add, Edit, Delete leads
- **View**: Card view or Table view toggle
- **Grouping**: Group by Industry, Sales Channel, Region, Lead Level, or None
- **Filtering**: Sidebar filters by Industry, Sales Channel, Region, Lead Level, CRM Status
- **Search**: Full-text search across all fields

### Lead Qualification Display
- Lead Score badge (0–100) shown on every card/row
- Lead Level badge (S/A/B/C/D) shown on every card/row
- Lead Value in THB shown on every card/row
- Color-coded visual indicators

### Odoo CRM Sync
- Toggle per-lead `crmSynced` status (manual: mark as synced)
- **Auto Sync Modal**: Settings panel for Odoo URL + API Key + database name
- Button to simulate/configure auto-sync to Odoo CRM
- "อัตราการซิงค์ Lead" stat shown in header

### Cold Email
- Button on each lead card to compose cold email
- Opens mailto: link or email modal with pre-filled template

### Analytics Dashboard
- Summary stat cards: Total Leads, Avg Score, Total Lead Value, Sync Rate
- Donut charts: by Industry, by Sales Channel
- Bar chart: Lead Score distribution
- All charts update dynamically when data changes

### CSV Export
- Export button downloads `wiring_harness_leads.csv` with UTF-8 BOM
- Compatible with Microsoft Excel (Thai characters display correctly)
- Includes all 15 columns

---

## Pending Tasks (from previous session)

The following features were **planned but NOT yet implemented** in the current `index.html`. These need to be built:

- [ ] **Lead Level Badge** — Add HTML/CSS for S/A/B/C/D badge display
- [ ] **Lead Level column** — Add to Card renderer and Table row renderer  
- [ ] **Add/Edit Form** — Replace single `leadScore` input with 4 sub-metric selects (ขนาดบริษัท, มูลค่าต่อปี, ศักยภาพ, กลยุทธ์) + auto-calculate total score
- [ ] **Detail Modal** — Show 4 sub-metric breakdown and Level badge
- [ ] **Grouping by Lead Level** — Add "ระดับของ Lead" to groupBy options
- [ ] **Sidebar filter by Lead Level** — Filter chips for S/A/B/C/D
- [ ] **CSV Export** — Include Lead Level column in export

---

## Design System

### Colors (CSS Variables)
```css
/* Light Mode */
--primary: #4f46e5;        /* Indigo */
--accent: #0d9488;         /* Teal */
--danger: #ef4444;
--success: #10b981;

/* Dark Mode */
--primary: #6366f1;
--accent: #14b8a6;
```

### Fonts
- Display/Headers: **Outfit** (Google Fonts)
- Body/UI: **Inter** (Google Fonts)

### Theme
- Supports **Light and Dark mode** via `[data-theme="dark"]` on `<html>`
- Uses glassmorphism cards with `backdrop-filter: blur()`
- Smooth micro-animations on hover/click

---

## Business Context

- **ผู้ใช้**: Sales ธุรกิจชุดสายไฟ (Wiring Harness) 
- **CRM หลัก**: Odoo CRM (ภายนอก) — LeadWire เป็นแค่ Lead Collector
- **เป้าหมายลูกค้า**: โรงงานในไทยหลายประเภท
- **ช่องทางการขาย**: OEM, Aftermarket Replacement, Aftermarket Upgrade, Repair Shop, Online Seller
- **อุตสาหกรรมเป้าหมาย**: Automotive, SPV, Home Appliance, Industrial, Agricultural Machinery
- **ภาษา UI**: ภาษาไทย (พร้อมคำภาษาอังกฤษในวงเล็บ)

---

## Important Notes for Claude Code

1. **ไฟล์หลักคือ `index.html`** — ไฟล์เดียวที่ต้องแก้ไข
2. **อย่าเปลี่ยน Tech Stack** — ไม่ต้องใช้ React, Vue, Next.js, ฯลฯ
3. **ใช้ UTF-8 BOM** สำหรับ CSV export เพื่อให้ Excel แสดง Thai ได้
4. **Lead data** อยู่ใน `const initialLeads = [...]` ในไฟล์ HTML โดยตรง — ไม่ใช่ external API
5. **Dark/Light theme** toggle ต้องทำงานต่อเนื่อง — อย่าลบ CSS variables
6. **คะแนน Lead** คำนวณจาก 4 มิติตาม Scoring System ด้านบน — ต้องสอดคล้องกัน
7. **"ระดับของ Lead"** (S/A/B/C/D badge) เป็น Feature ที่ยังค้างอยู่ — ดูหัวข้อ Pending Tasks
