class ReactionService {
  static Map<String, dynamic>? checkReaction(String subA, String subB) {
    // 1. Phản ứng trung hòa: Axit + Bazơ
    if ((subA == "HCl" && subB == "NaOH") ||
        (subA == "NaOH" && subB == "HCl")) {
      return {
        "equation": "\$HCl + NaOH \\rightarrow NaCl + H_2O\$",
        "phenomenon": "Phản ứng tỏa nhiệt, không có kết tủa.",
        "color": "transparent",
        "videoPath": "assets/videos/Bazo.mp4",
      };
    }
    // 2. Phản ứng tạo kết tủa: Muối + Axit
    if ((subA == "BaCl2" && subB == "H2SO4") ||
        (subA == "H2SO4" && subB == "BaCl2")) {
      return {
        "equation":
            "\$BaCl_2 + H_2SO_4 \\rightarrow BaSO_4 \\downarrow + 2HCl\$",
        "phenomenon": "Xuất hiện kết tủa trắng tinh khiết.",
        "color": "white",
        "videoPath": "assets/videos/snaptik.vn_RaRoH.mp4",
      };
    }
    // 3. Phản ứng nhận biết: Axit + Quỳ tím
    if ((subA == "Quỳ tím" && subB == "HCl") ||
        (subA == "HCl" && subB == "Quỳ tím")) {
      return {
        "equation": "Axit làm quỳ tím hóa đỏ",
        "phenomenon": "Giấy quỳ tím chuyển sang màu đỏ rực.",
        "color": "red",
        "imagePath": "assets/images/thi_nghiem_hcl.png",
      };
    }
    return null;
  }
}
