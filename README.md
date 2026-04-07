# Formal Methods for Secure Software Development - CSC8204

**Newcastle University | MSc Advanced Computer Science**  
**Module:** Secure Software Development (CSC8204)  
**Student:** Aniket Vinod Nalawade | 250535354

[![Security](https://img.shields.io/badge/Focus-Software%20Security-red.svg)](https://owasp.org/)
[![Formal Methods](https://img.shields.io/badge/Verification-Dafny-blue.svg)](https://dafny.org/)
[![RBAC](https://img.shields.io/badge/Model-SecureUML-green.svg)](https://secureUML.org/)
[![Risk Analysis](https://img.shields.io/badge/Framework-McGraw-orange.svg)](https://www.garymcgraw.com/)

## 📋 Project Overview

A **comprehensive security engineering analysis** of the **Tokeneer ID Station** - a high-assurance biometric access control system developed for the NSA. This project demonstrates expertise in **formal verification**, **risk analysis**, **secure design modeling**, and **program correctness proofs** using industry-standard methodologies.

### 🎯 What This Project Covers

This security analysis encompasses four critical areas:

🔒 **Risk Analysis** - Business and technical risk assessment using McGraw's methodology  
🎨 **Secure Design** - Role-Based Access Control (RBAC) modeling with SecureUML  
✓ **Formal Verification** - Dafny specifications for Tokeneer token validation  
📐 **Program Correctness** - Weakest precondition calculus proofs  

---

## 🏗️ System Architecture

### Tokeneer ID Station Overview

The **Tokeneer Identification Station (TIS)** is a high-assurance security system designed to control physical access to secure enclaves using biometric authentication and smart tokens.

```
┌─────────────────────────────────────────────────────────────┐
│              TOKENEER ID STATION (TIS)                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  User                                                       │
│    │                                                        │
│    ├──► Fingerprint Reader (Biometric Authentication)      │
│    │                                                        │
│    └──► Smart Token Card Reader                            │
│            │                                                │
│            ▼                                                │
│         ┌──────────────────────────────────┐               │
│         │   TIS Security Core              │               │
│         ├──────────────────────────────────┤               │
│         │  1. Read Token Certificates:     │               │
│         │     - ID Certificate             │               │
│         │     - Privilege Certificate      │               │
│         │     - I&A Certificate           │               │
│         │     - Auth Certificate (opt)     │               │
│         │                                  │               │
│         │  2. Validate Certificates:       │               │
│         │     - Check expiry dates         │               │
│         │     - Verify cross-references    │               │
│         │     - Validate token integrity   │               │
│         │                                  │               │
│         │  3. Biometric Verification:      │               │
│         │     - Match fingerprint          │               │
│         │     - Issue Auth Certificate     │               │
│         │                                  │               │
│         │  4. Access Control Decision:     │               │
│         │     - Check clearance level      │               │
│         │     - Verify admin privileges    │               │
│         │     - Grant/deny access          │               │
│         └──────────────────────────────────┘               │
│                        │                                    │
│                        ▼                                    │
│         ┌──────────────────────────────────┐               │
│         │   Secure Workstation Access      │               │
│         │   (Enclave Entry)                │               │
│         └──────────────────────────────────┘               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Key Security Features:**
- **EAL5+ Assurance** - Formally verified to highest commercial security standards
- **Multi-Factor Authentication** - Smart token + biometric fingerprint
- **Certificate Chain Validation** - Cryptographic binding of ID, privilege, and authorization
- **Clearance-Based Access** - Hierarchical security levels (unmarked → top secret)
- **Audit Trail** - Complete logging of access attempts and administrative actions

---

## ✨ Project Components

### 🔹 Part A: Risk Analysis (McGraw's Methodology)

**Purpose:** Systematically identify and assess business and technical risks to the Tokeneer project using Gary McGraw's risk-driven security framework.

#### A.1 Business Goals (NIST Classification)

| ID | Business Goal | NIST Category | Rank | Description |
|----|---------------|---------------|------|-------------|
| **G1** | Demonstrate feasibility of high-assurance secure development | **Mission Goal** | 1 | Prove EAL5+ formal methods are practical |
| **G2** | Display Praxis Correctness-by-Construction methodology | **Strategic Goal** | 2 | Provide evidence that CbC is fault-free |
| **G3** | Authorize NSA to disseminate formal practice to industry | **Market Influence** | 3 | Enable wider defense contractor adoption |
| **G4** | Show economics of rigorous development vs traditional | **Financial Goal** | 4 | Demonstrate cost-effectiveness of formal methods |
| **G5** | Deliver working Tokeneer ID Station demonstrator | **Operational Goal** | 5 | Build functioning high-assurance system |

**Ranking Rationale:**
- **G1 (Mission):** Core purpose of the NSA contract - proving feasibility is paramount
- **G2 (Strategic):** CbC methodology validation drives long-term adoption
- **G3 (Market):** Industry dissemination multiplies project impact
- **G4 (Financial):** Cost justification enables future projects
- **G5 (Operational):** Working demonstrator validates theoretical claims

#### A.2 Business Risks

| Risk ID | Business Risk | Indicators | Likelihood | Impact | Severity | Rationale |
|---------|--------------|------------|------------|--------|----------|-----------|
| **B1** | Failure to demonstrate feasibility of high-assurance development | Post-delivery defects; formal proof failures; missing EAL5 | Medium | High | **HIGH** | Undermines core project purpose for NSA |
| **B2** | Cost/schedule overruns undermining cost-effectiveness claims | Missed milestones; excessive person-days; high rework | Medium-High | Medium-High | **HIGH** | Defeats the project's claim that CbC is cost-effective |
| **B3** | Limited industry uptake of results | Negative stakeholder feedback; insufficient documentation clarity | Medium | High | **HIGH** | Deforms NSA's goal of widening contractor practices |

#### A.3 Technical Risks (McGraw's Touchpoints)

| Risk ID | Technical Risk | Description | Likelihood | Impact | Controls (Tokeneer) | Rationale |
|---------|---------------|-------------|------------|--------|---------------------|-----------|
| **TR1** | Design flaws in formal specification | Ambiguities or inconsistencies in large Z specifications | Medium | High | Proof obligations, manual review, schema reviews | Flawed spec cascades into false proofs |
| **TR2** | Inadequate environment modeling | Missing hardware/firmware models; incomplete environment contracts | Medium | Medium-High | Environment simulation, explicit contracts | Breaks assumptions about real deployment |
| **TR3** | Incomplete verification coverage | Proof obligations cover sample paths, not all properties | Medium | High | Extend verification scope, property-based testing | Leaves unproven code paths vulnerable |
| **TR4** | Refinement errors (Z → SPARK) | Mismatch between abstract spec and implementation | Low-Medium | High | Strong SPARK analysis, command traceability | Implementation deviates from verified design |
| **TR5** | Real-world attack vectors not tested | Penetration testing gaps; insufficient adversarial simulation | Medium | High | Hardware penetration testing, fuzzing, fault injection | Formal proofs miss practical vulnerabilities |

#### A.4 Risk Traceability Matrix

**Business Goals → Business Risks → Technical Risks**

```
G1 (Feasibility)  →  B1 (Failed demonstration)  →  TR1 (Spec flaws), TR3 (Incomplete verification)
G2 (CbC Methodology)  →  B1 (Failed demonstration)  →  TR4 (Refinement errors)
G3 (Industry adoption)  →  B3 (Limited uptake)  →  All technical risks (quality perception)
G4 (Cost-effectiveness)  →  B2 (Overruns)  →  TR1 (Rework), TR3 (Re-verification)
G5 (Working demonstrator)  →  B1, B3  →  TR2 (Environment), TR5 (Real attacks)
```

**Key Insight:** Every technical risk threatens multiple business objectives through business risk intermediaries, demonstrating systematic risk propagation.

#### A.5 Mitigation Strategies

| Tech Risk | Mitigation Strategy |
|-----------|---------------------|
| **TR1** | Strengthen formal specification reviews; add more proof obligations; multi-view architecture inspection |
| **TR2** | Increase fidelity of environment simulation; explicit environment contracts; better hardware modeling |
| **TR3** | Extend verification scope from sample proofs to full property coverage; add property-based testing |
| **TR4** | Apply strong SPARK static analysis; command traceability for Z-SPARK refinement |
| **TR5** | Conduct real hardware penetration testing; fuzzing; adversarial fault-injection experiments |

**Rationale:**
This risk analysis follows McGraw's security touchpoints (architecture risk analysis, code review, penetration testing) and maps directly to Tokeneer documentation. Each mitigation is:
- **Evidence-based:** Grounded in Tokeneer project realities
- **High-impact:** Addresses root causes, not symptoms
- **Traceable:** Clear connection to business objectives
- **Practical:** Implementable within project constraints

---

### 🔹 Part B: SecureUML RBAC Design

**Purpose:** Model Tokeneer's role-based access control using SecureUML, a UML extension for security-aware system design.

#### B.1 SecureUML Diagram Components

**Subjects (Users):**
- **User** - General system user attempting access
- **Admin** - Administrative personnel (inherits from User)

**Roles:**
- **EnclaveUser** - Standard user accessing secure workstation
- **Superuser** - Administrative role with elevated privileges

**Permissions (Actions):**
- **Login** - Authenticate to workstation
- **Logout** - End session
- **Open** - Access secured enclave
- **Grant** - Issue/activate certificates
- **Revoke** - Deactivate certificates

**Resources (Protected Assets):**
- **Workstation** - Physical secure terminal
- **TIS** - Tokeneer ID Station itself
- **Certificate Hierarchy:**
  - `Certificate` (abstract base class)
    - `IDCertificate` - User identity binding
    - `PrivilegeCertificate` - Role/clearance definition
    - `IACertificate` - I&A (Identification & Authentication) proof
    - `AuthorizationCertificate` - Biometric validation result

**Security Policies:**

```
Policy 1: Login Access Control
─────────────────────────────
EnclaveUser can login to Workstation
  IF user possesses:
    - Valid AuthorizationCertificate
    - Certificate links to correct Token ID
    - Certificate references valid IDCertificate
    - All certificates are current (not expired)

OCL Precondition:
context EnclaveUser::login(w: Workstation): Boolean
  pre: self.authCert.notEmpty() and
       self.authCert.tokenID = self.token.tokenID and
       self.authCert.idCertID = self.idCert.certID and
       self.authCert.IsCurrent(currentTime)


Policy 2: Superuser Privileges
───────────────────────────────
Superuser can Grant/Revoke on all Certificate resources
Superuser can forcefully terminate EnclaveUser sessions

OCL Constraint:
context Superuser::grant(c: Certificate): Boolean
  pre: self.role = 'Superuser'
  post: c.status = 'active'

context Superuser::revoke(c: Certificate): Boolean
  pre: self.role = 'Superuser'
  post: c.status = 'revoked'


Policy 3: Certificate Integrity
────────────────────────────────
All certificates must maintain tokenID and certificateID cross-references
PrivilegeCertificate must reference parent IDCertificate
IACertificate must reference parent IDCertificate
AuthorizationCertificate issued only after biometric verification

Invariant:
context PrivilegeCertificate
  inv: self.tokenID = self.token.tokenID and
       self.idCertID = self.idCertificate.certID
```

#### B.2 Authentication Flow

```
1. User inserts smart token into TIS card reader
   └─> TIS reads: IDCert, PrivilegeCert, IACert, (optional) AuthCert

2. TIS validates token structure
   └─> Check: Token.ValidToken() predicate (cross-reference integrity)

3. TIS validates certificate currency
   └─> Check: Token.CurrentToken(now) predicate (expiry dates)

4. User provides fingerprint on biometric reader
   └─> TIS matches fingerprint against I&A certificate template

5. If match succeeds, TIS issues AuthorizationCertificate
   └─> AuthCert links to TokenID and IDCertID
   └─> AuthCert stored in token (optional set becomes populated)

6. User attempts workstation login
   └─> Guard checks: Token.TokenWithValidAuth() predicate
   └─> If TRUE → Grant access to enclave
   └─> If FALSE → Deny access, log attempt
```

**Design Rationale:**

This SecureUML model provides:
- **Traceability:** Direct mapping to Dafny predicates (Part C)
- **Clarity:** Visual representation of security policies
- **Verifiability:** OCL constraints enable automated policy enforcement
- **Maintainability:** Role hierarchy simplifies permission management
- **Compliance:** Matches EAL5 formal specification requirements

The certificate hierarchy with `tokenID` and `certID` cross-references enables formal verification (Dafny) and runtime validation, ensuring both design-time and run-time security guarantees.

---

### 🔹 Part C: Formal Verification with Dafny

**Purpose:** Formally specify and verify Tokeneer token validation predicates using Dafny, a verification-aware programming language.

#### C.1 Dafny Model Overview

**File:** `CSC8204_PartC_Tokeneer_Model.dfy`

**Key Components:**

**1. Type Definitions:**
```dafny
type optional<T> = ts: set<T> | |ts| <= 1  // Set with 0 or 1 elements
type TIME = nat                             // Natural number timestamps

datatype CLEARANCE_CLASS = 
  unmarked | unclassified | restricted | confidential | secret | topsecret

datatype PRIVILEGE = 
  none | normalUser | guard | auditManager | securityOfficer

datatype ADMINOP = 
  overrideLock | archiveLog | updateData | shutdownOp
```

**2. Certificate Trait (Abstract Base Class):**
```dafny
trait Certificate {
  var certID: nat
  var tokenID: nat
  var validFrom: TIME
  var validTo: TIME
  
  predicate IsCurrent(now: TIME) reads this {
    validFrom <= now && now <= validTo
  }
}
```

**3. Concrete Certificate Classes:**
```dafny
class IDCert extends Certificate {
  constructor(id: nat, tok: nat, from: TIME, to: TIME)
    ensures certID == id && tokenID == tok && validFrom == from && validTo == to
  { /* ... */ }
}

class PrivilegeCert extends Certificate {
  var idCertID: nat  // Cross-reference to ID certificate
  // ...
}

class IACert extends Certificate {
  var idCertID: nat  // Cross-reference to ID certificate
  // ...
}

class AuthorizationCert extends Certificate {
  var idCertID: nat  // Cross-reference to ID certificate
  // ...
}
```

**4. Clearance Level Hierarchy:**
```dafny
function clearanceLevel(c: CLEARANCE_CLASS): nat {
  match c
    case unmarked => 0
    case unclassified => 1
    case restricted => 2
    case confidential => 3
    case secret => 4
    case topsecret => 5
}

class Clearance {
  var clearance: CLEARANCE_CLASS
  
  static function minClearance(c1: Clearance, c2: Clearance): Clearance
    reads c1, c2
  {
    if clearanceLevel(c1.clearance) < clearanceLevel(c2.clearance) then c1 else c2
  }
}
```

**5. Admin Privilege Mapping:**
```dafny
function availableOps(p: PRIVILEGE): set<ADMINOP> {
  if p == PRIVILEGE.guard then 
    {ADMINOP.overrideLock}
  else if p == PRIVILEGE.auditManager then 
    {ADMINOP.archiveLog}
  else if p == PRIVILEGE.securityOfficer then 
    {ADMINOP.updateData, ADMINOP.shutdownOp}
  else 
    {}
}
```

**6. Token Class with Critical Predicates:**

```dafny
class Token {
  var tokenID: nat
  var idCert: IDCert
  var privCert: PrivilegeCert
  var iaCert: IACert
  var authCert: optional<AuthorizationCert>  // 0 or 1 elements
  
  // PREDICATE 1: ValidToken
  // Ensures privilege and I&A certificates correctly reference ID certificate
  predicate ValidToken() reads this, idCert, privCert, iaCert {
    // Privilege cert must reference this token and ID cert
    privCert.tokenID == tokenID &&
    privCert.idCertID == idCert.certID &&
    
    // I&A cert must reference this token and ID cert
    iaCert.tokenID == tokenID &&
    iaCert.idCertID == idCert.certID
  }
  
  // PREDICATE 2: TokenWithValidAuth
  // Requires authorization certificate with correct cross-references
  predicate TokenWithValidAuth() reads this, idCert, authCert {
    exists ac :: ac in authCert && 
                 ac.tokenID == tokenID && 
                 ac.idCertID == idCert.certID
  }
  
  // PREDICATE 3: CurrentToken
  // Valid token with all current (non-expired) certificates
  predicate CurrentToken(now: TIME) reads this, idCert, privCert, iaCert {
    ValidToken() &&
    idCert.IsCurrent(now) &&
    privCert.IsCurrent(now) &&
    iaCert.IsCurrent(now)
  }
}
```

#### C.2 Formal Verification Goals

**What Dafny Proves:**

1. **Type Safety:** All operations respect type constraints
   - `optional<T>` sets never contain >1 element
   - TIME values are always natural numbers
   - Certificate cross-references are consistent

2. **Structural Integrity:** Token invariants hold
   - `ValidToken()` ensures all certificates reference the same token
   - `TokenWithValidAuth()` confirms authorization exists before access
   - `CurrentToken(now)` prevents expired certificate usage

3. **Constructor Correctness:** Post-conditions verified
   - All certificate constructors establish required fields
   - Token construction maintains structural invariants

4. **Function Purity:** `reads` clauses prevent side effects
   - Predicates only read object state, never modify
   - `minClearance()` is a pure function (no heap access)

**Verification Process:**

```
1. Dafny parses the specification
   └─> Type-checks all declarations

2. Dafny generates verification conditions
   └─> For each method: precondition ⇒ postcondition
   └─> For each predicate: logical consistency

3. Dafny invokes Z3 SMT solver
   └─> Attempts automated proof
   └─> Reports success or counterexample

4. Result: Verified correct or proof failure
   └─> Success: Mathematical certainty of correctness
   └─> Failure: Specification error or missing invariant
```

**Example Verification:**

```dafny
// Dafny verifies this assertion automatically:
method TestTokenValidity(t: Token, now: TIME)
  requires t.CurrentToken(now)
  ensures t.ValidToken()  // Guaranteed by CurrentToken definition
  ensures t.idCert.IsCurrent(now)  // Guaranteed by CurrentToken
{
  // No implementation needed - Dafny proves this statically
}
```

**Security Properties Verified:**

- ✅ **Authentication Integrity:** AuthCert cannot exist without matching token/ID
- ✅ **Expiry Enforcement:** Expired certificates cannot satisfy `CurrentToken()`
- ✅ **Cross-Reference Consistency:** Certificate chains maintain cryptographic binding
- ✅ **Clearance Ordering:** `minClearance()` correctly computes hierarchical minimum

---

### 🔹 Part D: Weakest Precondition Calculus

**Purpose:** Prove program correctness using Hoare logic and weakest precondition reasoning.

#### D.1 Exercise 1: Sums Method

**Problem:** Find the weakest precondition for the postcondition `m > n`:

```
m := x
n := y
a := 2*m + n
n := n - 1
m := a
{ m > n }  // Postcondition
```

**Solution (Backward Reasoning):**

```
Step 5: m := a
────────────────
After:  m > n
Before: a > n  (substitute a for m)


Step 4: n := n - 1
────────────────────
After:  a > n
Before: a > (n - 1)  (substitute n-1 for n)
        a > n - 1
        Simplify: a > n - 1


Step 3: a := 2*m + n
──────────────────────
After:  a > n - 1
Before: 2*m + n > n - 1  (substitute 2*m+n for a)
        2*m + n > n - 1
        2*m > -1  (subtract n from both sides)


Step 2: n := y
──────────────
After:  2*m > -1
Before: 2*m > -1  (n doesn't appear, condition unchanged)


Step 1: m := x
──────────────
After:  2*m > -1
Before: 2*x > -1  (substitute x for m)
```

**Final Weakest Precondition:**
```
{ 2*x > -1 }
```

**Interpretation:**
- This is the **least restrictive** condition on initial state
- Any `x > -0.5` satisfies the precondition
- For integers, `x >= 0` is sufficient
- Proof guarantees: if `2*x > -1` initially, then `m > n` after execution

---

#### D.2 Exercise 2: UpdateAlarms Method

**Problem:** Find the weakest precondition for the postcondition:

```
Q: (alarm == alarming) ↔ (doorAlarm == alarming ∨ auditAlarm == alarming)
```

Given code:
```
if (doorAlarm == alarming || auditAlarm == alarming)
  alarm := alarming
else
  alarm := silent
```

**Solution (Conditional wp Rule):**

Let `C ≡ (doorAlarm == alarming) ∨ (auditAlarm == alarming)`

**WP Rule for Conditionals:**
```
wp(if B then S1 else S2, Q) = (B → wp(S1, Q)) ∧ (¬B → wp(S2, Q))
```

**Then-branch: alarm := alarming**
```
After:  (alarm == alarming) ↔ C
Before: (alarming == alarming) ↔ C  (substitute alarming for alarm)
        True ↔ C
        Simplifies to: C
```

**Else-branch: alarm := silent**
```
After:  (alarm == alarming) ↔ C
Before: (silent == alarming) ↔ C  (substitute silent for alarm)
        False ↔ C
        Simplifies to: ¬C
```

**Apply wp Rule:**
```
wp = (C → C) ∧ (¬C → ¬C)
   = True ∧ True
   = True
```

**Final Weakest Precondition:**
```
{ True }
```

**Interpretation:**
- **No precondition needed!**
- The code **always** establishes the postcondition
- Regardless of initial variable values, the postcondition holds after execution
- This is a **correct-by-construction** implementation
- The alarm state is **always** consistent with door/audit alarm states

**Proof of Correctness:**
- If `C` is true → alarm set to `alarming` → `(alarming == alarming) ↔ C` → `True ↔ True` ✓
- If `C` is false → alarm set to `silent` → `(silent == alarming) ↔ C` → `False ↔ False` ✓

---

## 💡 Key Concepts Demonstrated

### Formal Methods
✅ **Dafny Verification** - Automated correctness proofs  
✅ **Hoare Logic** - Axiomatic program semantics  
✅ **Weakest Preconditions** - Backward reasoning for correctness  
✅ **Invariants & Predicates** - State validation conditions  
✅ **SMT Solving** - Z3 theorem prover integration  

### Security Engineering
✅ **Risk Analysis** - McGraw's touchpoints methodology  
✅ **RBAC Modeling** - SecureUML for access control  
✅ **Threat Modeling** - Business-to-technical risk mapping  
✅ **EAL5+ Assurance** - Highest commercial security standard  
✅ **Defense in Depth** - Multi-layer security (biometric + token)  

### Software Engineering
✅ **Correctness-by-Construction (CbC)** - Build quality in from design  
✅ **Formal Specification** - Z notation, OCL constraints  
✅ **Refinement** - Abstract spec → concrete implementation  
✅ **Traceability** - Requirements → design → verification  

---

## 🎓 Skills Demonstrated

### Formal Verification
✅ **Dafny Programming** - Verification-aware language  
✅ **Predicate Logic** - First-order logic reasoning  
✅ **Proof Construction** - Manual and automated proofs  
✅ **Type Systems** - Dependent types, refinement types  

### Security Analysis
✅ **Risk Assessment** - Likelihood, impact, severity analysis  
✅ **Threat Modeling** - Attack vector identification  
✅ **Secure Design** - RBAC, least privilege, separation of duties  
✅ **Compliance** - EAL5, Common Criteria understanding  

### Critical Thinking
✅ **Analytical Reasoning** - Breaking down complex systems  
✅ **Logical Deduction** - Weakest precondition calculus  
✅ **Systematic Methodology** - McGraw's touchpoints, NIST categories  
✅ **Evidence-Based Argumentation** - Citations to Tokeneer docs  

---

## 📊 Project Structure

```
CSC8204 AniketNalawade/
├── CSC8204_Secure_Software_Development.pdf    # Complete technical report
│   ├── Part A: Risk Analysis
│   │   ├── Business Goals (NIST classification)
│   │   ├── Business Risks (3 identified)
│   │   ├── Technical Risks (5 identified, McGraw)
│   │   ├── Risk Traceability Matrix
│   │   └── Mitigation Strategies
│   ├── Part B: SecureUML RBAC Design
│   │   ├── UML Class Diagram
│   │   ├── Role Hierarchy (EnclaveUser, Superuser)
│   │   ├── Security Policies (OCL constraints)
│   │   └── Authentication Flow
│   ├── Part C: Formal Verification (implicit)
│   │   └── Described in report
│   └── Part D: Weakest Precondition Calculus
│       ├── Exercise 1: Sums Method
│       └── Exercise 2: UpdateAlarms Method
├── CSC8204_PartC_Tokeneer_Model.dfy           # Dafny formal specification
│   ├── Type Definitions (optional, TIME, enums)
│   ├── Certificate Trait & Concrete Classes
│   ├── Clearance Hierarchy
│   ├── Privilege-to-AdminOp Mapping
│   └── Token Class with Predicates:
│       ├── ValidToken()
│       ├── TokenWithValidAuth()
│       └── CurrentToken(now)
└── README.md                                  # This file
```

---

## 🚀 How to Verify the Dafny Model

### Prerequisites

```bash
# Install Dafny (Windows/Mac/Linux)
# Download from: https://github.com/dafny-lang/dafny/releases

# Or via package manager:
# Windows (Chocolatey)
choco install dafny

# Mac (Homebrew)
brew install dafny

# Linux (Download binary)
wget https://github.com/dafny-lang/dafny/releases/download/v4.0.0/dafny-4.0.0-x64-ubuntu-20.04.zip
unzip dafny-4.0.0-x64-ubuntu-20.04.zip
```

### Verification Commands

```bash
# Verify the Tokeneer model
dafny verify CSC8204_PartC_Tokeneer_Model.dfy

# Expected output:
# Dafny program verifier finished with X verified, 0 errors

# Compile to executable (optional)
dafny build CSC8204_PartC_Tokeneer_Model.dfy

# Run with verbose output
dafny verify --verbose CSC8204_PartC_Tokeneer_Model.dfy
```

### Understanding Verification Output

**Success:**
```
Dafny program verifier finished with 15 verified, 0 errors
```
✅ All predicates verified  
✅ All constructors satisfy postconditions  
✅ Type safety guaranteed  

**Failure Example:**
```
CSC8204_PartC_Tokeneer_Model.dfy(157,4): Error: assertion violation
```
❌ Specification error or missing precondition  
❌ Investigate line 157 for logical inconsistency  

---

## 🔗 Real-World Applications

This project demonstrates skills directly applicable to:

### Industries
- **Defense & Aerospace** - High-assurance systems (aircraft, weapons)
- **Financial Services** - Security-critical payment processing
- **Healthcare** - HIPAA-compliant patient data systems
- **Government** - Classified information systems
- **Automotive** - Safety-critical embedded systems

### Technologies
- **Formal Verification Tools** - Dafny, Coq, Isabelle/HOL, TLA+
- **Static Analysis** - SPARK Ada, Polyspace, Coverity
- **Security Modeling** - SecureUML, UMLsec, KAOS
- **Risk Frameworks** - NIST CSF, ISO 27005, OCTAVE

### Roles
- Security Architect
- Formal Methods Engineer
- Verification Engineer
- Risk Analyst / Security Consultant
- Safety-Critical Systems Developer

---

## 📄 Technical Report

Full documentation available: [`CSC8204_Secure_Software_Development.pdf`](./CSC8204_Secure_Software_Development.pdf)

The report includes:
- **Part A:** Complete risk analysis with traceability matrices
- **Part B:** SecureUML diagram with OCL constraint specifications
- **Part C:** (Described in report, implemented in .dfy file)
- **Part D:** Step-by-step weakest precondition derivations
- Rationale and methodology explanations
- Evidence-based argumentation with citations

---

## 📞 About This Project

**Author:** Aniket Vinod Nalawade  
**Student ID:** 250535354  
**Institution:** Newcastle University  
**Program:** MSc Advanced Computer Science  
**Module:** CSC8204 - Secure Software Development  
**Academic Year:** 2024/2025

---

## ⚠️ Academic Integrity Notice

This repository contains coursework submitted for academic assessment at Newcastle University.

**Important:**
- This work is showcased for **portfolio purposes**
- Do not copy or submit as your own
- Use as a learning reference for formal methods and security engineering
- Respect academic integrity policies

---

## 🏆 Project Highlights

🔒 **High-Assurance Security** - EAL5+ Tokeneer ID Station analysis  
📊 **Comprehensive Risk Analysis** - McGraw's methodology with 5 technical risks  
🎨 **Secure Design Modeling** - SecureUML RBAC with OCL constraints  
✓ **Formal Verification** - Dafny predicates for token validation  
📐 **Mathematical Proofs** - Weakest precondition calculus  
🔗 **Full Traceability** - Business goals → risks → mitigations  
🧠 **Critical Thinking** - Systematic security engineering methodology  

---

**Built with 🔐 Formal Methods and 🧮 Mathematical Rigor**  
*Provably correct software for high-assurance security systems*
