/*
CSC8204 Part C
Extended Dafny model for Tokeneer tokens & certificates
*/

// basic types
type optional<T> = ts: set<T> | |ts| <= 1
type TIME = nat

// Example enumerated types (CLEARANCE_CLASS and PRIVILEGE are used by the exercises).
// If your original file already defines these, keep the original definitions and remove duplicates.
// Here they are included to make this file self-contained.

datatype CLEARANCE_CLASS = unmarked | unclassified | restricted | confidential | secret | topsecret

datatype PRIVILEGE = none | normalUser | guard | auditManager | securityOfficer

// ------------------------
// Trait and certificate types
// ------------------------

trait Certificate {
  var certID: nat
  var tokenID: nat
  var validFrom: TIME
  var validTo: TIME

  predicate IsCurrent(now: TIME) reads this
    { validFrom <= now && now <= validTo }
}

// Concrete certificate classes (simplified)
class IDCert extends Certificate {
  constructor(id: nat, tok: nat, from: TIME, to: TIME)
    ensures certID == id && tokenID == tok && validFrom == from && validTo == to
  {
    certID := id;
    tokenID := tok;
    validFrom := from;
    validTo := to;
  }
}

class PrivilegeCert extends Certificate {
  var idCertID: nat
  constructor(id: nat, tok: nat, idc: nat, from: TIME, to: TIME)
    ensures certID == id && tokenID == tok && idCertID == idc && validFrom == from && validTo == to
  {
    certID := id;
    tokenID := tok;
    idCertID := idc;
    validFrom := from;
    validTo := to;
  }
}

class IACert extends Certificate {
  var idCertID: nat
  constructor(id: nat, tok: nat, idc: nat, from: TIME, to: TIME)
    ensures certID == id && tokenID == tok && idCertID == idc && validFrom == from && validTo == to
  {
    certID := id;
    tokenID := tok;
    idCertID := idc;
    validFrom := from;
    validTo := to;
  }
}

class AuthorizationCert extends Certificate {
  var idCertID: nat
  constructor(id: nat, tok: nat, idc: nat, from: TIME, to: TIME)
    ensures certID == id && tokenID == tok && idCertID == idc && validFrom == from && validTo == to
  {
    certID := id;
    tokenID := tok;
    idCertID := idc;
    validFrom := from;
    validTo := to;
  }
}

// ------------------------
// 1) Clearance class and minClearance
// ------------------------

// Helper function to get numeric level of a clearance class
function clearanceLevel(c: CLEARANCE_CLASS): nat
{
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

  constructor ()
    ensures clearance == CLEARANCE_CLASS.unmarked
  {
    clearance := CLEARANCE_CLASS.unmarked;
  }

  // ghost function that returns the Clearance object with the lower (i.e. earlier) clearance
  static function minClearance(c1: Clearance, c2: Clearance): Clearance
    reads c1, c2
  {
    if clearanceLevel(c1.clearance) < clearanceLevel(c2.clearance) then c1 else c2
  }
}

// ------------------------
// 2) Admin Privilege: ADMINOP & availableOps function
// ------------------------

// 2a) New enumerated datatype representing admin operations
datatype ADMINOP = overrideLock | archiveLog | updateData | shutdownOp

// 2b) Function that returns the set of ADMINOPs available to a given PRIVILEGE
function availableOps(p: PRIVILEGE): set<ADMINOP>
{
  if p == PRIVILEGE.guard then {ADMINOP.overrideLock}
  else if p == PRIVILEGE.auditManager then {ADMINOP.archiveLog}
  else if p == PRIVILEGE.securityOfficer then {ADMINOP.updateData, ADMINOP.shutdownOp}
  else {}
}

// ------------------------
// 3) Token class with predicates
// ------------------------

class Token {
  var tokenID: nat
  var idCert: IDCert
  var privCert: PrivilegeCert
  var iaCert: IACert
  var authCert: optional<AuthorizationCert>  // optional authorization certificate (0 or 1)

  constructor(tid: nat, idc: IDCert, pc: PrivilegeCert, iac: IACert, ac: optional<AuthorizationCert>)
    ensures tokenID == tid && idCert == idc && privCert == pc && iaCert == iac && authCert == ac
  {
    tokenID := tid;
    idCert := idc;
    privCert := pc;
    iaCert := iac;
    authCert := ac;
  }

  // Predicate: ValidToken
  // A Valid Token has Privilege and I&A certificates correctly cross-referencing the ID Certificate and TokenID.
  predicate ValidToken() reads this, idCert, privCert, iaCert
  {
    // Ensure that privilege cert references this token and the id certificate
    privCert.tokenID == tokenID &&
    privCert.idCertID == idCert.certID &&

    // Ensure that I&A cert references this token and the id certificate
    iaCert.tokenID == tokenID &&
    iaCert.idCertID == idCert.certID
  }

  // Predicate: TokenWithValidAuth
  // Must have an Authorization certificate, and it must correctly cross-reference the token ID and ID certificate ID.
  predicate TokenWithValidAuth() reads this, idCert, authCert
  {
    // authCert is an optional set with 0 or 1 elements. We require there exists an ac in authCert
    // such that it cross-references token and id certificate.
    exists ac :: ac in authCert && ac.tokenID == tokenID && ac.idCertID == idCert.certID
  }

  // Predicate: CurrentToken(now)
  // A Current Token is a Valid Token where all the certificates (id, privilege, I&A) are current at time now.
  predicate CurrentToken(now: TIME) reads this, idCert, privCert, iaCert
  {
    ValidToken() &&
    idCert.IsCurrent(now) &&
    privCert.IsCurrent(now) &&
    iaCert.IsCurrent(now)
  }
}