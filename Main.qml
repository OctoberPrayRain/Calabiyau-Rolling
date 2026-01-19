import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 1280
    height: 850
    visible: true
    title: "卡拉彼丘：战术部署终端"

    // --- 数据与状态保持不变 ---
    property var maps: ["88区", "404基地", "奥卡努斯", "柯西街区", "欧拉港口", "科斯迷特", "空间实验室", "风曳镇"]
    property var scissorsPool: ["明","拉薇","梅瑞狄斯","令","香奈美","艾卡","珐格兰丝","玛拉","星绘","奥黛丽","玛德蕾娜","绯莎","白墨","加拉蒂亚"]
    property var pusPool: ["米雪儿李","信","心夏","伊薇特","芙拉薇娅","忧雾","蕾欧娜","千代","星绘","奥黛丽","玛德蕾娜","绯莎","白墨","加拉蒂亚"]
    
    property int click_count: 0  
    property string currentMap: ""
    property bool showCharacters: false 
    
    property var teamA_S: []; property var teamA_P: []
    property var teamB_S: []; property var teamB_P: []

    background: Rectangle {
        color: "#121212"
        Image {
            anchors.fill: parent
            source: currentMap !== "" ? "images/maps/" + currentMap + ".png" : ""
            fillMode: Image.PreserveAspectCrop
            opacity: 0.5
        }
    }

    Column {
        anchors.centerIn: parent 
        spacing: 30

        Text {
            id: resultText 
            text: {
                if (click_count === 0) return "准备确认作战区域...";
                if (click_count === 1 && !showCharacters) return "目标战场：" + currentMap;
                if (click_count <= 5) return "A队 - 选手 " + click_count;
                if (click_count <= 10) return "B队 - 选手 " + (click_count - 5);
                return "5V5 战术部署总览";
            }
            color: "white"
            font.pointSize: 40; font.bold: true
            style: Text.Outline; styleColor: "black"
            anchors.horizontalCenter: parent.horizontalCenter 
        }

        // --- 抽取过程中的立绘显示 (1-10次显示) ---
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            visible: showCharacters && click_count > 0 && click_count <= 10

            Column {
                spacing: 10
                Image {
                    id: sImage
                    width: 380; height: 380; fillMode: Image.PreserveAspectFit
                    source: {
                        if (!showCharacters) return "";
                        if (click_count <= 5 && teamA_S.length > 0) return "images/" + teamA_S[click_count - 1] + ".png"
                        if (click_count > 5 && teamB_S.length > 0) return "images/" + teamB_S[click_count - 6] + ".png"
                        return ""
                    }
                    Behavior on source { SequentialAnimation { NumberAnimation { target: sImage; property: "scale"; from: 0.8; to: 1.0; duration: 200; easing.type: Easing.OutBack } } }
                }
                Text { text: "进攻方"; color: "#FF5733"; font.bold: true; font.pointSize: 24; anchors.horizontalCenter: parent.horizontalCenter; style: Text.Outline; styleColor: "black"}
            }

            Column {
                spacing: 10
                Image {
                    id: pImage
                    width: 380; height: 380; fillMode: Image.PreserveAspectFit
                    source: {
                        if (!showCharacters) return "";
                        if (click_count <= 5 && teamA_P.length > 0) return "images/" + teamA_P[click_count - 1] + ".png"
                        if (click_count > 5 && teamB_P.length > 0) return "images/" + teamB_P[click_count - 6] + ".png"
                        return ""
                    }
                    Behavior on source { SequentialAnimation { NumberAnimation { target: pImage; property: "scale"; from: 0.8; to: 1.0; duration: 200; easing.type: Easing.OutBack } } }
                }
                Text { text: "防守方"; color: "#33C1FF"; font.bold: true; font.pointSize: 24; anchors.horizontalCenter: parent.horizontalCenter; style: Text.Outline; styleColor: "black"}
            }
        }

        // --- 阶段性文字提示 (1-10次显示) ---
        Text {
            visible: showCharacters && click_count <= 10
            textFormat: Text.RichText
            font.pointSize: 40; font.bold: true; color: "white"
            style: Text.Outline; styleColor: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                if (!showCharacters || click_count > 10) return "";
                var s = (click_count <= 5) ? teamA_S[click_count-1] : teamB_S[click_count-6];
                var p = (click_count <= 5) ? teamA_P[click_count-1] : teamB_P[click_count-6];
                return "<font color='#FF5733'>" + s + "</font> & <font color='#33C1FF'>" + p + "</font>";
            }
        }

        // --- 汇总界面：分块白色背景展示 ---
        Row {
            visible: click_count > 10
            spacing: 50
            anchors.horizontalCenter: parent.horizontalCenter

            // A队 面板
            Rectangle {
                width: 450; height: 450
                color: Qt.rgba(1, 1, 1, 0.85) // 半透明白色背景
                radius: 15; border.color: "#FF5733"; border.width: 4
                
                Column {
                    anchors.fill: parent; anchors.margins: 20; spacing: 15
                    Text { text: "A 队 (剪刀手起始)"; font.pointSize: 22; font.bold: true; color: "#FF5733"; anchors.horizontalCenter: parent.horizontalCenter }
                    Rectangle { width: parent.width; height: 2; color: "#DDD" } // 分割线
                    Repeater {
                        model: 5
                        Text {
                            text: "选手 " + (index + 1) + ":  <font color='#CC4400'>" + teamA_S[index] + "</font>  |  <font color='#006699'>" + teamA_P[index] + "</font>"
                            textFormat: Text.RichText; font.pointSize: 18; font.bold: true
                        }
                    }
                }
            }

            // B队 面板
            Rectangle {
                width: 450; height: 450
                color: Qt.rgba(1, 1, 1, 0.85)
                radius: 15; border.color: "#33C1FF"; border.width: 4
                
                Column {
                    anchors.fill: parent; anchors.margins: 20; spacing: 15
                    Text { text: "B 队 (欧泊起始)"; font.pointSize: 22; font.bold: true; color: "#33C1FF"; anchors.horizontalCenter: parent.horizontalCenter }
                    Rectangle { width: parent.width; height: 2; color: "#DDD" }
                    Repeater {
                        model: 5
                        Text {
                            text: "选手 " + (index + 1) + ":   <font color='#006699'>" + teamB_P[index] + "</font> | <font color='#CC4400'>" + teamB_S[index] + "</font>"
                            textFormat: Text.RichText; font.pointSize: 18; font.bold: true
                        }
                    }
                }
            }
        }

        Button {
            text: {
                if (click_count === 0) return "抽取对战地图";
                if (click_count === 1 && !showCharacters) return "开始部署 A 队角色";
                if (click_count === 5) return "进入 B 队部署";
                if (click_count < 10) return "下一位选手";
                if (click_count === 10) return "查看战术总览";
                return "重置系统";
            }
            font.pointSize: 25; padding: 15
            anchors.horizontalCenter: parent.horizontalCenter 
            onClicked: {
                if (click_count === 0) {
                    currentMap = maps[Math.floor(Math.random() * maps.length)];
                    click_count = 1; showCharacters = false; return;
                }
                if (click_count === 1 && !showCharacters) {
                    var sPool = scissorsPool.slice(); var pPool = pusPool.slice();
                    function sh(a) { for(var i=a.length-1;i>0;i--){var j=Math.floor(Math.random()*(i+1));[a[i],a[j]]=[a[j],a[i]];} return a;}
                    sPool = sh(sPool); pPool = sh(pPool);
                    teamA_S = sPool.slice(0, 5); teamA_P = pPool.slice(0, 5);
                    teamB_S = sPool.slice(5, 10); teamB_P = pPool.slice(5, 10);
                    showCharacters = true; return;
                }
                if (click_count <= 10) { click_count++; } 
                else { click_count = 0; showCharacters = false; teamA_S = []; teamB_S = []; currentMap = ""; }
            }
        }   
    }
}