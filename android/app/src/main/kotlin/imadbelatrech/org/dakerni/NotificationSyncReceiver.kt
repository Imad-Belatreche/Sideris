package imadbelatrech.org.sideris

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.work.Data
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import dev.fluttercommunity.workmanager.BackgroundWorker

class NotificationSyncReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val taskName = "sideris-notification-sync"
        val input = Data.Builder()
            .putString(BackgroundWorker.DART_TASK_KEY, taskName)
            .build()
        val request = OneTimeWorkRequest.Builder(BackgroundWorker::class.java)
            .setInputData(input)
            .build()

        WorkManager.getInstance(context).enqueueUniqueWork(
            "sideris-notification-sync-on-time-change",
            ExistingWorkPolicy.REPLACE,
            request,
        )
    }
}
